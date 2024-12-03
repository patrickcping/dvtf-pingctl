variables {
  test_name = "variable-data-types"
}

provider "davinci" {
  environment_id = run.pingone_setup.dv_admin_environment_id

    # Ensure the following environment variables are set to prepare the PingOne provider
    # Ref: https://registry.terraform.io/providers/pingidentity/davinci/latest/docs#schema
    # Ensure the following environment variables are set:
    # - PINGONE_USERNAME
    # - PINGONE_PASSWORD
    # - PINGONE_REGION
}

run "pingone_setup" {
  module {
    source = "./../../../bootstrap-hcl"

    # Ensure the following environment variables are set to prepare the PingOne provider
    # Ref: https://registry.terraform.io/providers/pingidentity/pingone/latest/docs#provider-schema-reference
    # - PINGONE_CLIENT_ID
    # - PINGONE_CLIENT_SECRET
    # - PINGONE_ENVIRONMENT_ID
    # - PINGONE_REGION_CODE
  }
}

run "plan_success" {

  variables {
    pingone_environment_id = run.pingone_setup.pingone_environment_id
    davinci_variable_variabletypesecret_value = "testvalue"
  }

  command = plan

  assert {
    condition     = davinci_variable.variabletypesecret.value == "testvalue"
    error_message = "Variable value is not as expected"
  }
}

run "apply_success" {

  variables {
    pingone_environment_id = run.pingone_setup.pingone_environment_id
    davinci_variable_variabletypesecret_value = "testvalue"
  }

  command = apply

  # assert {
  #   condition     = ..
  #   error_message = ..
  # }
}
