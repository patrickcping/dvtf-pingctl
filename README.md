# dvtf-pingctl

A simple CLI tool to assist HCL generation and debugging with using the [DaVinci Terraform provider](https://registry.terraform.io/providers/pingidentity/davinci/latest).

* Supported DaVinci Terraform provider version: `v0.4.2+`

> [!IMPORTANT]  
> Content in this repository is under development and isn't yet functional.

## Config Generation

Generate HCL configuration from a DaVinci service JSON export file.

Supports exports with or without subflows.

Only `davinci_flow`, `davinci_variable`, and `davinci_connector` resources are supported.

Individual resources can be selected using the `--resource` flag (`-r` for short), and if this flag is omitted, all resources will be generated.

Examples:

```shell
dvtf-pingctl generate --export-file-path /path/to/my/export.json
dvtf-pingctl generate -e /path/to/my/export.json
dvtf-pingctl generate --export-file-path /path/to/my/export.json --resource davinci_flow --resource davinci_variable --resource davinci_connector
dvtf-pingctl generate -e /path/to/my/export.json -r davinci_flow -r davinci_variable -r davinci_connector
cat /path/to/my/export.json | dvtf-pingctl generate --resource davinci_flow
cat /path/to/my/export.json | dvtf-pingctl generate -r davinci_flow
```

## Flow Validation (for use with the `davinci_flow` resource)

Validate the JSON export file as an input to the "davinci_flow" Terraform provider resource.

Supports only exports without subflows (as per the Terraform provider).

Examples:

```shell
dvtf-pingctl validate --export-file-path /path/to/my/export.json
dvtf-pingctl validate -e /path/to/my/export.json
cat /path/to/my/export.json | dvtf-pingctl validate
```

To validate the JSON input for a specific davinci_flow field in the case of debugging state, use the `--field` flag (`-f` for short):

```shell
dvtf-pingctl validate --export-file-path /path/to/my/export.json --field flow_configuration_json
dvtf-pingctl validate -e /path/to/my/export.json -f flow_configuration_json
cat /path/to/my/export.json | dvtf-pingctl validate --field flow_configuration_json
cat /path/to/my/export.json | dvtf-pingctl validate -f flow_configuration_json
```

## TODO

- Output directory path as a parameter (currently `./testoutput`)
- Overwrite parameter switch (currently fails if the output directory already exists)
- `davinci_connector` `property` block generation based on connector definition
- Testing
- Brew install
- Multi-arch install
- Unit tests
- Debug logging