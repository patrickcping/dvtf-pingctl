# Refreshing the connector schema

From the project root:

```sh
davinci-pingcli connectors schema --json | jq '[.[] | .accountConfigView.items as $items | {"name": .name, "connectorId": .connectorId, "connectorCategories": .connectorCategories, "properties": (.properties // {} | with_entries(select(.key as $k | ($items // [] | map(.propertyName)) | index($k))))}] | sort_by(.connectorId)' > internal/generate/connector_schema/connector-schema.json
```

[github.com/patrickcping/davinci-pingcli](https://github.com/patrickcping/davinci-pingcli) for information on use.
