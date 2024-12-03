variables {
  test_name = "ciam-passwordless-flow-pack"
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
  }

  command = plan

  # assert {
  #   condition     = ..
  #   error_message = ..
  # }
}

run "properties_generated" {

  variables {
    pingone_environment_id = run.pingone_setup.pingone_environment_id

    davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_envId = run.pingone_setup.pingone_environment_id
    davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientId = run.pingone_setup.pingone_application_client_id
    davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientSecret = run.pingone_setup.pingone_application_client_secret
    davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_region = run.pingone_setup.pingone_region_code

    davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_enforcedSignedToken = true
  }

  command = plan

  // Test for properties generated
  assert {
    condition     = length(davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.property) > 0
    error_message = "Properties not generated for davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a"
  }
  assert {
    condition     = length(davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.property) == 4
    error_message = format("Expecting 4 properties configured for davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a, got %s", nonsensitive(length(davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.property)))
  }

  // Test for connectors with no properties in the schema
  assert {
    condition     = length(davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.property) == 0
    error_message = format("Expecting 0 properties configured for davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8, got %s", nonsensitive(length(davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.property)))
  }

  // Test for connectors with properties in the schema but none configured in the variables
  assert {
    condition     = length(davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.property) == 0
    error_message = format("Expecting 0 properties configured for davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949, got %s", nonsensitive(length(davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.property)))
  }

  // Test bool data type
  assert {
    condition     = tolist(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property)[index(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property.*.name, "enforcedSignedToken")].type == "boolean"
    error_message = format("Expecting enforcedSignedToken to be of type boolean, got %s", nonsensitive(tolist(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property)[index(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property.*.name, "enforcedSignedToken")].type))
  }
  assert {
    condition     = tolist(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property)[index(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property.*.name, "enforcedSignedToken")].value == "true"
    error_message = format("Expecting enforcedSignedToken to have string bool value, got %s", nonsensitive(tolist(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property)[index(davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.property.*.name, "enforcedSignedToken")].value))
  }
}

run "apply_success" {

  variables {
    pingone_environment_id = run.pingone_setup.pingone_environment_id
  }

  command = apply

  # assert {
  #   condition     = ..
  #   error_message = ..
  # }
}
