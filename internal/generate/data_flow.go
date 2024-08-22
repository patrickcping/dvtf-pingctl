package generate

type flowData struct {
	commonData
	DependsOnVarRefs []string
	Name             *string
	Description      *string
	FlowJSONPath     string
	ConnectionLinks  []flowConnectionLink
	SubflowLinks     []flowSubflowLink
}

type flowConnectionLink struct {
	ConnectionRefID     string
	ConnectorID         string
	ReplaceConnectionID string
}

type flowSubflowLink struct {
	FlowRefID        string
	SubFlowName      string
	ReplaceSubflowID string
}
