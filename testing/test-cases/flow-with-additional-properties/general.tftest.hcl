variables {
  test_name = "flow-with-additional-properties"
}

run "plan_success" {

  command = plan

  # assert {
  #   condition     = ..
  #   error_message = ..
  # }
}

run "apply_success" {

  command = apply

  # assert {
  #   condition     = ..
  #   error_message = ..
  # }
}
