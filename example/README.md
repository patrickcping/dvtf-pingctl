# dvtf-pingctl Example

The following shows an example of using the command line tool with an export from DaVinci.

The flow example has been exported **with subflows** and **with variable values** included.  The flow export has one main flow, and two subflows included.

## Generate

The first step in this example is to use the `dvtf-pingctl generate ...` command to parse the export, generate the required HCL and split the flows into their component files.

```shell
cat ./../assets/flows/multiple-flows.json | dvtf-pingctl generate --output-dir `pwd`/output
```

The result of the generate routine can be found in the [output](./output) directory, the components are:

```
├── assets
│   ├── flows
│   │   ├── abcd123_subflow_1.json
│   │   ├── abcd123_subflow_1.json
│   │   ├── full_basic.json
├── davinci_connectors.tf
├── davinci_flows.tf
└── davinci_variables.tf
```

The `assets/flows/` directory contains the flows that have been found in the export file.  Each one of these flows can be validated using the `dvtf-pingctl validate ...` command.

The generated files `davinci_connectors.tf`, `davinci_variables.tf` contain variables and connectors that are shared between all the nodes in the export.  Variables that are `flow` variables (and must be attached to a specific flow) have been defined with a reference to their `davinci_flow` resource.

The generated file `davinci_flows.tf` contains the flow definitions for each of the flows embedded in the JSON.  The output includes variable `depends_on` definitions, and contains the relevant `connection_link` and `subflow_link` blocks required for safe import.

## Validate

Once files have been generated, the flows themselves can be validated using the `dvtf-pingctl validate ...` command.

```shell
cat ./output/assets/flows/full_basic.json | dvtf-pingctl validate
cat ./output/assets/flows/abcd123_subflow_1.json | dvtf-pingctl validate
cat ./output/assets/flows/abcd123_subflow_2.json | dvtf-pingctl validate
```

The output can be used to determine whether the flows will successfully import using the DaVinci Terraform provider, or whether they need re-exporting.

The output can be provided to the DaVinci Terraform provider maintainers to improve the provider.
