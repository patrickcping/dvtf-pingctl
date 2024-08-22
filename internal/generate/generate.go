package generate

import (
	"fmt"
	"os"
	"regexp"
	"slices"
	"strings"
	"text/template"

	"github.com/google/go-cmp/cmp"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/samir-gandhi/davinci-client-go/davinci"
)

type DaVinciGenerator struct {
	exportBytes     []byte
	path            string
	outputPath      string
	resources       []terraform.ProviderResource
	flowsData       []flowData
	connectionsData []connectionData
	variablesData   []variableData
	overwriteExport bool
}

func New(exportMap []byte, resources []terraform.ProviderResource) *DaVinciGenerator {
	return &DaVinciGenerator{
		exportBytes:     exportMap,
		resources:       resources,
		overwriteExport: false,
		outputPath:      "/Users/patrickcowland/Documents/dvtf-cli/testoutput",
	}
}

func (d *DaVinciGenerator) SetPath(path string) {
	d.path = path
}

func (d *DaVinciGenerator) Generate(version string) error {
	// Parse the flow
	flowExport, err := d.parseFlow()
	if err != nil {
		return err
	}

	// Build the template objects
	err = d.buildData(flowExport, true)
	if err != nil {
		return err
	}

	// Write the HCL configuration
	err = d.write(version)
	if err != nil {
		return err
	}

	return nil
}

func (d *DaVinciGenerator) parseFlow() (any, error) {

	cmpOpts := davinci.ExportCmpOpts{
		IgnoreConfig:              false,
		IgnoreDesignerCues:        true,
		IgnoreEnvironmentMetadata: false,
		IgnoreUnmappedProperties:  true,
		IgnoreVersionMetadata:     true,
		IgnoreFlowMetadata:        false,
		IgnoreFlowVariables:       false,
	}

	data := &davinci.Flows{}
	err := davinci.Unmarshal(d.exportBytes, data, cmpOpts)
	if err != nil {
		return nil, err
	}

	if cmp.Equal(data, &davinci.Flows{}) {
		data := &davinci.Flow{}
		err := davinci.Unmarshal(d.exportBytes, data, cmpOpts)
		if err != nil {
			return nil, err
		}
		return data, nil
	}

	return data, nil
}

func (d *DaVinciGenerator) buildData(data any, top bool) (err error) {

	var path *string
	if top {
		path = &d.path
	}

	switch t := data.(type) {
	case *davinci.Flows:
		for _, flow := range t.Flow {
			err := d.buildData(flow, false)
			if err != nil {
				return err
			}
		}
	case *davinci.Flow:
		err := d.buildDataSingleFlow(*t, path)
		if err != nil {
			return err
		}
	case davinci.Flow:
		err := d.buildDataSingleFlow(t, path)
		if err != nil {
			return err
		}
	default:
		return fmt.Errorf("Unknown data type: %T", data)
	}

	return nil
}

func (d *DaVinciGenerator) buildDataSingleFlow(flow davinci.Flow, path *string) (err error) {
	l := logger.Get()
	l.Debug().Msgf("buildDataSingleFlow Command called.")

	flowResourceName := d.sanitiseResourceName(flow.Name)

	pathVar := fmt.Sprintf("./assets/flows/%s_%d.json", flowResourceName, flow.CreatedDate.Unix())
	if path != nil {
		pathVar = *path
	}

	flowConnectionLinks := make([]flowConnectionLink, 0)
	subflowLinks := make([]flowSubflowLink, 0)
	dependsOnVarRefs := make([]string, 0)

	// Variables
	for _, variable := range flow.Variables {

		if variable.Context == nil || variable.Fields == nil || variable.Fields.Type == nil {
			return fmt.Errorf("Potentially corrupt DaVinci export file.  Variable %s is missing required fields", variable.Name)
		}

		reg := regexp.MustCompile(`^([a-zA-Z0-9]*)[[#]{2}.+]*$`)

		// Find the first match and capture groups
		matches := reg.FindStringSubmatch(variable.Name)

		variableName := variable.Name

		// Check if we have a match
		if len(matches) == 2 {
			// matches[0] is the full match
			// matches[1] is the first capture group
			variableName = matches[1]
		} else {
			return fmt.Errorf("No match found for variable name parsing: %s", variable.Name)
		}

		resourceName := d.sanitiseResourceName(variableName)

		var flowIDRef *string
		if variable.FlowID == nil && slices.Contains([]string{"flowInstance", "company", "user"}, *variable.Context) {
			if !slices.Contains(dependsOnVarRefs, resourceName) {
				dependsOnVarRefs = append(dependsOnVarRefs, resourceName)
			}
		} else {
			sanistisedFlowIDRef := d.sanitiseResourceName(flowResourceName)
			flowIDRef = &sanistisedFlowIDRef
			resourceName += "__" + *flowIDRef
		}

		d.variablesData = append(d.variablesData, variableData{
			commonData: commonData{
				CommentInformation: "// Flow Name: " + flow.Name,
				ResourceName:       resourceName,
			},
			Context:     *variable.Context,
			FlowIDRef:   flowIDRef,
			Name:        variableName,
			Type:        *variable.Fields.Type,
			Description: d.sanitiseStringFieldPtr(variable.Fields.DisplayName),
			Value:       variable.Fields.Value,
			Min:         variable.Fields.Min,
			Max:         variable.Fields.Max,
			Mutable:     variable.Fields.Mutable,
		})
	}

	// Connectors
	if flow.GraphData != nil && flow.GraphData.Elements != nil && len(flow.GraphData.Elements.Nodes) > 0 {
		nodes := flow.GraphData.Elements.Nodes
		for _, node := range nodes {

			if nodeData := node.Data; nodeData != nil && nodeData.ConnectorID != nil && nodeData.ConnectionID != nil && nodeData.ID != nil {

				resourceName := d.sanitiseResourceName(*nodeData.Name)

				if !slices.ContainsFunc(d.connectionsData, func(v connectionData) bool {
					return v.ID == *nodeData.ConnectorID
				}) {
					d.connectionsData = append(d.connectionsData, connectionData{
						commonData: commonData{
							CommentInformation: "// Flow Name: " + flow.Name,
							ResourceName:       resourceName,
						},
						ID:   *nodeData.ConnectorID,
						Name: *nodeData.Name,
					})
				}

				if !slices.ContainsFunc(flowConnectionLinks, func(v flowConnectionLink) bool {
					return v.ReplaceConnectionID == *nodeData.ConnectionID
				}) {
					flowConnectionLinks = append(flowConnectionLinks, flowConnectionLink{
						ConnectionRefID:     resourceName,
						ConnectorID:         *nodeData.ConnectorID,
						ReplaceConnectionID: *nodeData.ConnectionID,
					})
				}

				if nodeData.Properties != nil && nodeData.Properties.SubFlowID != nil && nodeData.Properties.SubFlowID.Value != nil {
					subflowID := nodeData.Properties.SubFlowID.Value

					if subflowID.Label == nil || subflowID.Value == nil {
						return fmt.Errorf("Potentially corrupt DaVinci export file.  Subflow connector with ID %s is missing required fields", *nodeData.ID)
					}

					if !slices.ContainsFunc(subflowLinks, func(v flowSubflowLink) bool {
						return v.ReplaceSubflowID == *subflowID.Value
					}) {
						subflowLinks = append(subflowLinks, flowSubflowLink{
							FlowRefID:        d.sanitiseResourceName(*subflowID.Label),
							SubFlowName:      *subflowID.Label,
							ReplaceSubflowID: *subflowID.Value,
						})
					}
				}

			} else {
				l.Debug().Msgf("Node skipped: %v", node)
			}
		}
	}

	// Flows
	d.flowsData = append(d.flowsData, flowData{
		commonData: commonData{
			CommentInformation: "// Flow Name: " + d.sanitiseStringField(flow.Name),
			ResourceName:       flowResourceName,
		},
		DependsOnVarRefs: dependsOnVarRefs,
		Name:             d.sanitiseStringFieldPtr(&flow.Name),
		Description:      d.sanitiseStringFieldPtr(flow.Description),
		FlowJSONPath:     pathVar,
		ConnectionLinks:  flowConnectionLinks,
		SubflowLinks:     subflowLinks,
	})

	return nil
}

func (d *DaVinciGenerator) write(version string) error {

	_, err := os.Stat(d.outputPath)
	if err == nil && !d.overwriteExport {
		return fmt.Errorf("generated import file directory for %q already exists. Use --overwrite to overwrite existing export data", d.outputPath)
	}

	err = os.MkdirAll(d.outputPath, os.ModePerm)
	if err != nil {
		return fmt.Errorf("failed to create directory %q. err: %s", d.outputPath, err.Error())
	}

	if slices.Contains(d.resources, terraform.ProviderResourceTypeVariable) {
		err := d.writeVariables(version)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeConnection) {
		err := d.writeConnections(version)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeFlow) {
		err := d.writeFlows(version)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeVariables(version string) error {

	var templateString string

	switch version {
	case "0.4":
		templateString = HCLVariableResourceTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLVariableResource").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse variable HCL template. err: %s", err.Error())
	}

	fileName := d.outputPath + fmt.Sprintf("/davinci_variables.tf")

	outputFile, err := os.Create(fileName)
	defer outputFile.Close()
	if err != nil {
		return err
	}

	for _, variableData := range d.variablesData {
		err = hclTemplate.Execute(outputFile, variableData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeConnections(version string) error {

	var templateString string

	switch version {
	case "0.4":
		templateString = HCLConnectionResourceTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLConnectionResource").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse connection HCL template. err: %s", err.Error())
	}

	fileName := d.outputPath + fmt.Sprintf("/davinci_connectors.tf")

	outputFile, err := os.Create(fileName)
	defer outputFile.Close()
	if err != nil {
		return err
	}

	for _, connectionData := range d.connectionsData {
		err = hclTemplate.Execute(outputFile, connectionData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeFlows(version string) error {
	var templateString string

	switch version {
	case "0.4":
		templateString = HCLFlowResourceTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLFlowResource").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse flow HCL template. err: %s", err.Error())
	}

	fileName := d.outputPath + fmt.Sprintf("/davinci_flows.tf")

	outputFile, err := os.Create(fileName)
	defer outputFile.Close()
	if err != nil {
		return err
	}

	for _, flowData := range d.flowsData {
		err = hclTemplate.Execute(outputFile, flowData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) sanitiseResourceName(name string) string {
	return strings.ToLower(regexp.MustCompile(`[^\w]+`).ReplaceAllString(name, "_"))
}

func (d *DaVinciGenerator) sanitiseStringField(value string) string {
	return strings.TrimSpace(value)
}

func (d *DaVinciGenerator) sanitiseStringFieldPtr(value *string) *string {
	if value == nil {
		return nil
	}

	returnVar := d.sanitiseStringField(*value)
	return &returnVar
}
