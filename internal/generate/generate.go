package generate

import (
	"encoding/json"
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
	path            *string
	outputPath      string
	resources       []terraform.ProviderResource
	flowsData       []flowData
	connectionsData []connectionData
	variablesData   []variableData
	flowAssets      []flowAssetData
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
	d.path = &path
}

func (d *DaVinciGenerator) Generate(version string) error {
	// Parse the flow
	flowExport, parsedIntf, err := d.parseFlow()
	if err != nil {
		return err
	}

	// Build the template objects
	err = d.buildData(flowExport, parsedIntf, true)
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

func (d *DaVinciGenerator) parseFlow() (any, map[string]interface{}, error) {

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
		return nil, nil, err
	}

	if cmp.Equal(data, &davinci.Flows{}) {
		data := &davinci.Flow{}
		err := davinci.Unmarshal(d.exportBytes, data, cmpOpts)
		if err != nil {
			return nil, nil, err
		}

		var parsedIntf map[string]interface{}
		err = json.Unmarshal(d.exportBytes, &parsedIntf)
		if err != nil {
			return nil, nil, err
		}

		return data, parsedIntf, nil
	}

	var parsedIntf map[string]interface{}
	err = json.Unmarshal(d.exportBytes, &parsedIntf)
	if err != nil {
		return nil, nil, err
	}

	return data, parsedIntf, nil
}

func (d *DaVinciGenerator) buildData(data any, parsedIntf map[string]interface{}, top bool) (err error) {

	var path *string
	if top && d.path != nil {
		path = d.path
	}

	switch t := data.(type) {
	case *davinci.Flows:
		for _, flow := range parsedIntf["flows"].([]interface{}) {
			flowName := flow.(map[string]interface{})["name"].(string)

			for _, flowObj := range t.Flow {
				if flowObj.Name == flowName {
					err := d.buildData(flowObj, flow.(map[string]interface{}), false)
					if err != nil {
						return err
					}
				}
			}
		}
	case *davinci.Flow:
		err := d.buildDataSingleFlow(*t, parsedIntf, path)
		if err != nil {
			return err
		}
	case davinci.Flow:
		err := d.buildDataSingleFlow(t, parsedIntf, path)
		if err != nil {
			return err
		}
	default:
		return fmt.Errorf("Unknown data type: %T", data)
	}

	return nil
}

func (d *DaVinciGenerator) buildDataSingleFlow(flow davinci.Flow, parsedIntf map[string]interface{}, path *string) (err error) {
	l := logger.Get()
	l.Debug().Msgf("buildDataSingleFlow Command called.")

	flowResourceName := d.sanitiseResourceName(flow.Name)

	pathVar := fmt.Sprintf("assets/flows/%s_%d.json", flowResourceName, flow.CreatedDate.Unix())
	createFlow := true
	if path != nil {
		pathVar = *path
		createFlow = false
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
	slices.SortFunc(flowConnectionLinks, func(i, j flowConnectionLink) int {
		return strings.Compare(i.ConnectorID, j.ConnectorID)
	})

	slices.SortFunc(subflowLinks, func(i, j flowSubflowLink) int {
		return strings.Compare(i.SubFlowName, j.SubFlowName)
	})

	slices.Sort(dependsOnVarRefs)

	d.flowsData = append(d.flowsData, flowData{
		commonData: commonData{
			CommentInformation: "// Flow Name: " + d.sanitiseStringField(flow.Name),
			ResourceName:       flowResourceName,
		},
		DependsOnVarRefs: dependsOnVarRefs,
		Name:             d.sanitiseStringFieldPtr(&flow.Name),
		Description:      d.sanitiseStringFieldPtr(flow.Description),
		FlowJSONPath:     fmt.Sprintf("./%s", pathVar),
		ConnectionLinks:  flowConnectionLinks,
		SubflowLinks:     subflowLinks,
	})

	if createFlow {
		d.flowAssets = append(d.flowAssets, flowAssetData{
			flowMap: parsedIntf,
			path:    pathVar,
		})
	}

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
		slices.SortFunc(d.variablesData, func(i, j variableData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeVariables(version)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeConnection) {
		slices.SortFunc(d.connectionsData, func(i, j connectionData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeConnections(version)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeFlow) {
		slices.SortFunc(d.flowsData, func(i, j flowData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeFlows(version)
		if err != nil {
			return err
		}
	}

	err = d.writeAssets()
	if err != nil {
		return err
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

func (d *DaVinciGenerator) writeAssets() error {

	outputDir := d.outputPath + fmt.Sprintf("/assets/flows/")

	err := os.MkdirAll(outputDir, os.ModePerm)
	if err != nil {
		return fmt.Errorf("failed to create directory %q. err: %s", outputDir, err.Error())
	}

	for _, flowAsset := range d.flowAssets {
		err = d.writeAsset(flowAsset)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeAsset(flowAsset flowAssetData) error {

	fileData, err := json.MarshalIndent(flowAsset.flowMap, "", "  ")

	err = os.WriteFile(fmt.Sprintf("%s/%s", d.outputPath, flowAsset.path), fileData, 0644)
	if err != nil {
		return fmt.Errorf("Cannot write asset file %s: %s", flowAsset.path, err)
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
