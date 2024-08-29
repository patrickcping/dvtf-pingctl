package generate

type variableData struct {
	commonData
	Context     string
	FlowIDRef   *string
	Name        string
	Type        string
	Description *string
	Value       *variableDataValue
	Min         *int32
	Max         *int32
	Mutable     *bool
}

type variableDataValue struct {
	JSON *string
	Text *string
}
