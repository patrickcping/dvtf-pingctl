# dvtf-pingctl

A simple CLI tool to assist HCL generation and debugging with using the [DaVinci Terraform provider](https://registry.terraform.io/providers/pingidentity/davinci/latest).

* Supported DaVinci Terraform provider version: `v0.4.2+`

> [!IMPORTANT]  
> Content in this repository is under development and isn't yet functional.

## Install

Only Homebrew is supported initially, for other methods of install please [raise an issue](https://github.com/patrickcping/dvtf-pingctl/issues/new?title=New%20installation%20method%20required).

### Homebrew

```shell
brew tap patrickcping/dvtf-pingctl
brew install dvtf-pingctl
```

Test the installation with:

```shell
dvtf-pingctl --help
```

## Example Usage

Visit the [example](./example/) to view a full example of generation and validation starting with a multi-flow export.

## Config Generation

Generate HCL configuration from a DaVinci service JSON export file.

Supports exports with or without subflows.

Only `davinci_flow`, `davinci_variable`, and `davinci_connector` resources are supported.

Individual resources can be selected using the `--resource` flag (`-r` for short), and if this flag is omitted, all resources will be generated.

Examples where the JSON is provided as a parameter:

```shell
dvtf-pingctl generate --export-file-path /path/to/my/export.json
dvtf-pingctl generate -e /path/to/my/export.json
dvtf-pingctl generate --export-file-path /path/to/my/export.json --resource davinci_flow --resource davinci_variable --resource davinci_connector
dvtf-pingctl generate -e /path/to/my/export.json -r davinci_flow -r davinci_variable -r davinci_connector
```

Examples where the JSON payload is provided via pipe:

```shell
cat /path/to/my/export.json | dvtf-pingctl generate
cat /path/to/my/export.json | dvtf-pingctl generate --resource davinci_flow --resource davinci_variable --resource davinci_connector
cat /path/to/my/export.json | dvtf-pingctl generate -r davinci_flow -r davinci_variable -r davinci_connector
```

## Flow Validation (for use with the `davinci_flow` resource)

Validate the JSON export file as an input to the "davinci_flow" Terraform provider resource.

Supports only exports without subflows (as per the Terraform provider).

Examples where the JSON is provided as a parameter:

```shell
dvtf-pingctl validate --export-file-path /path/to/my/export.json
dvtf-pingctl validate -e /path/to/my/export.json
```

Example where the JSON is provided via pipe:

```shell
cat /path/to/my/export.json | dvtf-pingctl validate
```

To validate the JSON input for a specific davinci_flow field in the case of debugging state, use the `--field` flag (`-f` for short):

Examples where the JSON is provided as a parameter:

```shell
dvtf-pingctl validate --export-file-path /path/to/my/export.json --field flow_configuration_json
dvtf-pingctl validate -e /path/to/my/export.json -f flow_configuration_json
```

Example where the JSON is provided via pipe:

```shell
cat /path/to/my/export.json | dvtf-pingctl validate --field flow_configuration_json
cat /path/to/my/export.json | dvtf-pingctl validate -f flow_configuration_json
```

### Return Codes

The `dvtf-pingctl validate ...` command will return the following return status codes:

- `0` - Successful validation, no warnings
- `1` - Unsuccessful validation
- `2` - Successful validation, with warnings

## TODO

- `davinci_connector` `property` block generation based on connector definition
- Testing
- Multi-arch install
- Unit tests
- Debug logging