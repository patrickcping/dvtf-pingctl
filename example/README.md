# dvtf-pingctl Example

The following shows an example of using the command line tool with an export from DaVinci.

The flow example has been exported **with subflows** and **with variable values** included.  The flow export has one main flow, and two subflows included.

## Generate

The first step in this example is to use the `dvtf-pingctl generate ...` command to parse the export, generate the required HCL and split the flows into their component files.

The example flow used is sourced from the [CIAM Passwordless Flow Pack](https://library.pingidentity.com/page/ciam-passwordless-flow-pack) on the [Ping Library](https://library.pingidentity.com)

```shell
cat ./../assets/flows/ciam-passwordless-flow-pack.json | dvtf-pingctl generate --output-path `pwd`/output
```

The command generates a Terraform module.  The generated module can be found in the [output](./output) directory that was set in the `dvtf-pingctl generate ...` command. The components are:

```
├── assets
│   ├── flows
│   │   ├── ciam_passwordless_protect_account_recovery_subflow.json
│   │   ├── ciam_passwordless_protect_account_registration_subflow.json
│   │   ├── ciam_passwordless_protect_agreement_tos_subflow.json
│   │   ├── ciam_passwordless_protect_change_password_subflow.json
│   │   ├── ciam_passwordless_protect_device_authentication_subflow.json
│   │   ├── ciam_passwordless_protect_device_registration_subflow.json
│   │   ├── ciam_passwordless_protect_magic_link_authentication_subflow.json
│   │   ├── ciam_passwordless_protect_registration_authentication_account_recovery_main_flow.json
│   │   ├── ciam_passwordless_protect_threat_detection_subflow.json
│   │   ├── ciam_passwordless_protect_verify_email_subflow.json
│   │   ├── ootb_basic_profile_management.json
│   │   ├── ootb_change_password_subflow_1.json
│   │   ├── ootb_device_management_main_flow.json
│   │   ├── ootb_device_registration_subflow_1.json
│   │   ├── ootb_password_reset_main_flow.json
├── davinci_connection_property_vars.tf
├── davinci_connectors.tf
├── davinci_flow_vars.tf
├── davinci_flows.tf
└── davinci_variable_vars.tf
└── davinci_variables.tf
└── vars.tf
└── versions.tf
```

The `assets/flows/` directory contains the flows that have been found in the export file.  Each one of these flows can be validated using the `dvtf-pingctl validate ...` command.

The generated Terraform files `davinci_connectors.tf`, `davinci_variables.tf` contain variables and connectors that are shared between all the nodes in the export.  Variables that are `flow` variables (and must be attached to a specific flow) have been defined with a reference to their `davinci_flow` resource.

The generated file `davinci_flows.tf` contains the flow definitions for each of the flows embedded in the JSON.  The output includes variable `depends_on` definitions, and contains the relevant `connection_link` and `subflow_link` blocks required for safe import.

Connector property values and variable values have been exposed as Terraform variables, and can be overriden as needed.

To use the generated code, construct a module call in your HCL as follows:

```hcl
module "davinci_flows" {
  source = "./output"

  // Required variable
  pingone_environment_id = pingone_environment.my_environment.id

  // Overridden variable values
  davinci_variable_agreementid_value           = ... // Define overriding variable values in the module call
  davinci_variable_ciam_magiclinkenabled_value = ... // Define overriding variable values in the module call
  # ... other variable values

  // Overridden connector values
  davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientId     = ... // Define overriding connector property values in the module call
  davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientSecret = ... // Define overriding connector property values in the module call 
  davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_envId        = ... // Define overriding connector property values in the module call
  davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_region       = ... // Define overriding connector property values in the module call
  # ... other connector property values
}

## Validate

Once files have been generated, the flows themselves can be validated using the `dvtf-pingctl validate ...` command.

```shell
cat ./output/assets/flows/full_basic.json | dvtf-pingctl validate
cat ./output/assets/flows/abcd123_subflow_1.json | dvtf-pingctl validate
cat ./output/assets/flows/abcd123_subflow_2.json | dvtf-pingctl validate

cat ./output/assets/flows/ciam_passwordless_protect_account_recovery_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_account_registration_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_agreement_tos_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_change_password_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_device_authentication_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_device_registration_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_magic_link_authentication_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_registration_authentication_account_recovery_main_flow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_threat_detection_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ciam_passwordless_protect_verify_email_subflow.json | dvtf-pingctl validate
cat ./output/assets/flows/ootb_basic_profile_management.json | dvtf-pingctl validate
cat ./output/assets/flows/ootb_change_password_subflow_1.json | dvtf-pingctl validate
cat ./output/assets/flows/ootb_device_management_main_flow.json | dvtf-pingctl validate
cat ./output/assets/flows/ootb_device_registration_subflow_1.json | dvtf-pingctl validate
cat ./output/assets/flows/ootb_password_reset_main_flow.json | dvtf-pingctl validate
```

The output can be used to determine whether the flows will successfully import using the DaVinci Terraform provider, or whether they need re-exporting.

The output can be provided to the DaVinci Terraform provider maintainers to improve the provider.
