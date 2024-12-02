package generate

import (
	_ "embed"
)

//go:embed connector_schema/connector-schema.json
var connectorSchemaBytes []byte
