package generate

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"regexp"
	"slices"
	"strings"
	"text/template"

	"github.com/patrickcping/dvtf-pingctl/internal/generate/export"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/samir-gandhi/davinci-client-go/davinci"
)

type DaVinciGenerator struct {
	exportDefs      []export.DaVinciGeneratorExport
	outputPath      string
	resources       []terraform.ProviderResource
	flowsData       []flowData
	connectionsData []connectionData
	variablesData   []variableData
	flowAssets      []flowAssetData
}

func New(exportDefs []export.DaVinciGeneratorExport, resources []terraform.ProviderResource, outputPath string) *DaVinciGenerator {
	return &DaVinciGenerator{
		exportDefs: exportDefs,
		resources:  resources,
		outputPath: outputPath,
	}
}

func (d *DaVinciGenerator) Generate(version string, overwrite bool) error {
	// Parse the flow
	err := d.parseFlows()
	if err != nil {
		return err
	}

	// Build the template objects
	for _, exportDef := range d.exportDefs {

		if exportDef.ParsedFlow == nil {
			return errors.New("exportDef or exportDef.ParsedFlow is nil")
		}

		err = d.buildData(exportDef.ParsedFlow.FlowObject, exportDef.ParsedFlow.ParsedIntf, exportDef.Path, true)
		if err != nil {
			return err
		}
	}

	// Write the HCL configuration
	err = d.write(version, overwrite)
	if err != nil {
		return err
	}

	return nil
}

func (d *DaVinciGenerator) parseFlows() error {

	newExportDefs := make([]export.DaVinciGeneratorExport, 0)

	for _, exportDef := range d.exportDefs {

		if !exportDef.IsParsed() {
			err := exportDef.ParseFlow()
			if err != nil {
				return err
			}
		}

		newExportDefs = append(newExportDefs, exportDef)

	}

	d.exportDefs = newExportDefs

	return nil
}

func (d *DaVinciGenerator) buildData(data any, parsedIntf map[string]interface{}, path *string, top bool) (err error) {

	var buildPath *string
	if top && path != nil {
		buildPath = path
	}

	switch t := data.(type) {
	case *davinci.Flows:
		for _, flow := range parsedIntf["flows"].([]interface{}) {
			flowName := flow.(map[string]interface{})["name"].(string)

			for _, flowObj := range t.Flow {
				if flowObj.Name == flowName {
					err := d.buildData(flowObj, flow.(map[string]interface{}), nil, false)
					if err != nil {
						return err
					}
				}
			}
		}
	case *davinci.Flow:
		err := d.buildDataSingleFlow(*t, parsedIntf, buildPath)
		if err != nil {
			return err
		}
	case davinci.Flow:
		err := d.buildDataSingleFlow(t, parsedIntf, buildPath)
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

	pathVar := fmt.Sprintf("assets/flows/%s.json", flowResourceName)
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

		reg := regexp.MustCompile(`^([a-zA-Z0-9-_]*)[[#]{2}.+]*$`)

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

		var variableValue *string
		if variable.Fields.Value != nil {
			v := fmt.Sprintf("%v", variable.Fields.Value)
			variableValue = &v
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
			Value:       variableValue,
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

				resourceName := d.sanitiseResourceName(fmt.Sprintf("%s__%s", *nodeData.ConnectorID, *nodeData.ConnectionID))

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
		FlowJSONPath:     fmt.Sprintf("%s", pathVar),
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

func (d *DaVinciGenerator) write(version string, overwrite bool) error {

	_, err := os.Stat(d.outputPath)
	if err == nil && !overwrite {
		return fmt.Errorf("generated import file directory for %q already exists. Remove the directory first or use --overwrite to overwrite any existing generated files", d.outputPath)
	}

	err = ensureDirExists(d.outputPath)
	if err != nil {
		return err
	}

	if slices.Contains(d.resources, terraform.ProviderResourceTypeVariable) {
		slices.SortFunc(d.variablesData, func(i, j variableData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeVariables(version, overwrite)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeConnection) {
		slices.SortFunc(d.connectionsData, func(i, j connectionData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeConnections(version, overwrite)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeFlow) {
		slices.SortFunc(d.flowsData, func(i, j flowData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeFlows(version, overwrite)
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

func (d *DaVinciGenerator) writeVariables(version string, overwrite bool) error {

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

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

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

func (d *DaVinciGenerator) writeConnections(version string, overwrite bool) error {

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

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

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

func (d *DaVinciGenerator) writeFlows(version string, overwrite bool) error {
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

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

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
	if value == nil || *value == "" {
		return nil
	}

	returnVar := d.sanitiseStringField(*value)
	return &returnVar
}

func ensureDirExists(dirPath string) error {
	// Check if the directory exists
	_, err := os.Stat(dirPath)
	if os.IsNotExist(err) {
		// Directory does not exist, create it
		err = os.MkdirAll(dirPath, os.ModePerm)
		if err != nil {
			return fmt.Errorf("failed to create directory %q: %v", dirPath, err)
		}
	} else if err != nil {
		// An error other than "directory does not exist" occurred
		return fmt.Errorf("failed to check directory %q: %v", dirPath, err)
	}
	return nil
}
