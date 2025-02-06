package generate

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"slices"
	"strings"
	"text/template"

	"github.com/patrickcping/dvtf-pingctl/internal/generate/export"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/output"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/samir-gandhi/davinci-client-go/davinci"
)

type DaVinciGenerator struct {
	exportDefs      []export.DaVinciGeneratorExport
	outputPath      string
	resources       []terraform.ProviderResource
	FlowsData       []flowData
	ConnectionsData []connectionData
	VariablesData   []variableData
	flowAssets      []flowAssetData
	flowNames       map[string]string
}

func New(exportDefs []export.DaVinciGeneratorExport, resources []terraform.ProviderResource, outputPath string) *DaVinciGenerator {
	return &DaVinciGenerator{
		exportDefs: exportDefs,
		resources:  resources,
		outputPath: outputPath,
		flowNames:  map[string]string{},
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

	// Re-write the subflow names to fix issue https://github.com/patrickcping/dvtf-pingctl/issues/11
	d.rewriteSubflowNames()

	// Write the HCL configuration
	err = d.write(version, overwrite)
	if err != nil {
		return err
	}

	return nil
}

func (d *DaVinciGenerator) rewriteSubflowNames() {
	updatedFlowsData := make([]flowData, 0)
	for _, flowData := range d.FlowsData {
		updatedSubflowLinks := make([]flowSubflowLink, 0)
		for _, subflowLink := range flowData.SubflowLinks {
			if subFlowName, ok := d.flowNames[subflowLink.ReplaceSubflowID]; ok {
				// update the subflow link name
				subflowLink.FlowRefID = sanitiseResourceName(subFlowName)
				subflowLink.SubFlowName = subFlowName
			} else {
				// Issue warning that subflow hasn't been included in the `-e` param list
				output.Print(output.Opts{
					Message: "Warning: Subflow has not been found in any of the JSON files provided in the `-e` param list. Plan errors may occur.",
					Fields: map[string]interface{}{
						"Missing Subflow ID": subflowLink.ReplaceSubflowID,
					},
				})
			}
			updatedSubflowLinks = append(updatedSubflowLinks, subflowLink)
		}
		flowData.SubflowLinks = updatedSubflowLinks

		updatedFlowsData = append(updatedFlowsData, flowData)
	}

	d.FlowsData = updatedFlowsData
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

	flowResourceName := sanitiseResourceName(flow.Name)
	d.flowNames[flow.FlowID] = flow.Name

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

		variableName := ""

		// Find the first match and capture groups
		matches := reg.FindStringSubmatch(variable.Name)
		// Check if we have a match
		if len(matches) == 2 {
			// matches[0] is the full match
			// matches[1] is the first capture group
			variableName = matches[1]
		} else {
			return fmt.Errorf("No match found for variable name parsing: %s", variable.Name)
		}

		resourceName := sanitiseResourceName(variableName)

		var flowIDRef *string
		if variable.FlowID == nil && slices.Contains([]string{"flowInstance", "company", "user"}, *variable.Context) {
			if !slices.Contains(dependsOnVarRefs, resourceName) {
				dependsOnVarRefs = append(dependsOnVarRefs, resourceName)
			}
		} else {
			sanistisedFlowIDRef := sanitiseResourceName(flowResourceName)
			flowIDRef = &sanistisedFlowIDRef
			resourceName += "__" + *flowIDRef
		}

		if !slices.ContainsFunc(d.VariablesData, func(v variableData) bool {
			return v.ResourceName == resourceName
		}) {

			var variableValue *variableDataValue
			if variable.Fields.Value != nil {
				variableValue = parseFieldValue(variable.Fields.Value)
			}

			terraformType, providerType, sensitive := getVariableGeneratorTypes(*variable.Fields.Type)

			if terraformType == "any" && variableValue != nil && variableValue.JSON != nil {
				// Escape JSON string
				*variableValue.JSON = strings.ReplaceAll(*variableValue.JSON, `"`, `\"`)
			}

			d.VariablesData = append(d.VariablesData, variableData{
				commonData: commonData{
					CommentInformation: "// Flow Name: " + flow.Name,
					ResourceName:       resourceName,
				},
				Context:       *variable.Context,
				FlowIDRef:     flowIDRef,
				Name:          variableName,
				ProviderType:  providerType,
				TerraformType: terraformType,
				Sensitive:     sensitive,
				Description:   sanitiseStringFieldPtr(variable.Fields.DisplayName),
				Value:         variableValue,
				Min:           variable.Fields.Min,
				Max:           variable.Fields.Max,
				Mutable:       variable.Fields.Mutable,
			})
		}
	}

	// Connectors
	if flow.GraphData != nil && flow.GraphData.Elements != nil && len(flow.GraphData.Elements.Nodes) > 0 {
		nodes := flow.GraphData.Elements.Nodes
		for _, node := range nodes {

			if nodeData := node.Data; nodeData != nil && nodeData.ConnectorID != nil && nodeData.ConnectionID != nil && nodeData.ID != nil {

				resourceName := sanitiseResourceName(fmt.Sprintf("%s__%s", *nodeData.ConnectorID, *nodeData.ConnectionID))

				if !slices.ContainsFunc(d.ConnectionsData, func(v connectionData) bool {
					return v.ResourceName == resourceName
				}) {
					connectionProperties, err := getConnectionProperties(*nodeData.ConnectorID)
					if err != nil {
						return fmt.Errorf("Failed to get connection properties for connector ID %s: %s", *nodeData.ConnectorID, err)
					}

					d.ConnectionsData = append(d.ConnectionsData, connectionData{
						commonData: commonData{
							CommentInformation: "// Flow Name: " + flow.Name,
							ResourceName:       resourceName,
						},
						ID:         *nodeData.ConnectorID,
						Name:       *nodeData.Name,
						Properties: connectionProperties,
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
							FlowRefID:        sanitiseResourceName(*subflowID.Label),
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

	d.FlowsData = append(d.FlowsData, flowData{
		commonData: commonData{
			CommentInformation: "// Flow Name: " + sanitiseStringField(flow.Name),
			ResourceName:       flowResourceName,
		},
		DependsOnVarRefs: dependsOnVarRefs,
		Name:             sanitiseStringFieldPtr(&flow.Name),
		Description:      sanitiseStringFieldPtr(flow.Description),
		FlowJSONPath:     pathVar,
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

	err = d.writeBaseVersions(version, overwrite)
	if err != nil {
		return err
	}

	err = d.writeBaseVars(version, overwrite)
	if err != nil {
		return err
	}

	if slices.Contains(d.resources, terraform.ProviderResourceTypeVariable) {
		slices.SortFunc(d.VariablesData, func(i, j variableData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeVariables(version, overwrite)
		if err != nil {
			return err
		}
		err = d.writeVariableVars(version, overwrite)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeConnection) {
		slices.SortFunc(d.ConnectionsData, func(i, j connectionData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeConnections(version, overwrite)
		if err != nil {
			return err
		}
		err = d.writeConnectionsPropertyVars(version, overwrite)
		if err != nil {
			return err
		}
	}
	if slices.Contains(d.resources, terraform.ProviderResourceTypeFlow) {
		slices.SortFunc(d.FlowsData, func(i, j flowData) int {
			return strings.Compare(i.ResourceName, j.ResourceName)
		})
		err := d.writeFlows(version, overwrite)
		if err != nil {
			return err
		}
		err = d.writeFlowVars(version, overwrite)
		if err != nil {
			return err
		}
		err = d.writeFlowOutputs(version, overwrite)
		if err != nil {
			return err
		}
	}

	err = d.writeAssets()
	if err != nil {
		return err
	}

	err = d.writeReadme(version, overwrite)
	if err != nil {
		return err
	}

	return nil
}

func (d *DaVinciGenerator) writeBaseVars(version string, overwrite bool) error {

	var templateString string

	switch version {
	case "0.4":
		templateString = HCLVarsTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLVars").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse vars HCL template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/vars.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	err = hclTemplate.Execute(outputFile, nil)
	if err != nil {
		return err
	}

	return nil
}

func (d *DaVinciGenerator) writeBaseVersions(version string, overwrite bool) error {

	var templateString string

	switch version {
	case "0.4":
		templateString = HCLVersionsTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLVersions").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse vars HCL template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/versions.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	err = hclTemplate.Execute(outputFile, nil)
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

	fileName := fmt.Sprintf("%s/davinci_variables.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, variableData := range d.VariablesData {
		err = hclTemplate.Execute(outputFile, variableData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeVariableVars(version string, overwrite bool) error {

	var templateString string

	switch version {
	case "0.4":
		templateString = HCLVariableResourceVarsTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLVariableResourceVars").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse variable HCL template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/davinci_variable_vars.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, variableData := range d.VariablesData {
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

	fileName := fmt.Sprintf("%s/davinci_connectors.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, connectionData := range d.ConnectionsData {
		err = hclTemplate.Execute(outputFile, connectionData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeConnectionsPropertyVars(version string, overwrite bool) error {

	var templateString string

	switch version {
	case "0.4":
		templateString = HCLConnectionPropertyVarsTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLConnectionPropertyVars").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse connection properties HCL template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/davinci_connection_property_vars.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, connectionData := range d.ConnectionsData {
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

	fileName := fmt.Sprintf("%s/davinci_flows.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, flowData := range d.FlowsData {
		err = hclTemplate.Execute(outputFile, flowData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeFlowVars(version string, overwrite bool) error {
	var templateString string

	switch version {
	case "0.4":
		templateString = HCLFlowResourceVarsTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLFlowResourceVars").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse flow HCL template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/davinci_flow_vars.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, flowData := range d.FlowsData {
		err = hclTemplate.Execute(outputFile, flowData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeFlowOutputs(version string, overwrite bool) error {
	var templateString string

	switch version {
	case "0.4":
		templateString = HCLFlowResourceOutputsTemplate_0_4
	}

	// Parse the HCL import block template
	hclTemplate, err := template.New("HCLFlowResourceOutputs").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse flow HCL template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/davinci_flow_outputs.tf", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	for _, flowData := range d.FlowsData {
		err = hclTemplate.Execute(outputFile, flowData)
		if err != nil {
			return err
		}
	}

	return nil
}

func (d *DaVinciGenerator) writeReadme(version string, overwrite bool) error {
	var templateString string

	switch version {
	case "0.4":
		templateString = ReadMeTemplate_0_4
	}

	// Parse the template
	readmeTemplate, err := template.New("ReadMe").Parse(templateString)
	if err != nil {
		return fmt.Errorf("failed to parse readme template. err: %s", err.Error())
	}

	fileName := fmt.Sprintf("%s/README.md", d.outputPath)

	// Check if the file exists
	if _, err := os.Stat(fileName); err == nil {
		if !overwrite {
			return fmt.Errorf("file %s already exists and overwrite is set to false", fileName)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("failed to check if file exists: %v", err)
	}

	fileName = filepath.Clean(fileName)
	outputFile, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	err = readmeTemplate.Execute(outputFile, d)
	if err != nil {
		return err
	}

	return nil
}

func (d *DaVinciGenerator) writeAssets() error {

	outputDir := fmt.Sprintf("%s/assets/flows/", d.outputPath)

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
	if err != nil {
		return fmt.Errorf("Cannot marshal asset data: %s", err)
	}

	err = os.WriteFile(fmt.Sprintf("%s/%s", d.outputPath, flowAsset.path), fileData, 0644)
	if err != nil {
		return fmt.Errorf("Cannot write asset file %s: %s", flowAsset.path, err)
	}

	return nil
}
