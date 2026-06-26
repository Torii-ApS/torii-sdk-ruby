# ToriiBackendGenerated::ServerUserSearchRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Filter by name (case-insensitive substring match). Send null to require users with no name. | [optional] |
| **email** | **String** | Filter by primary email (case-insensitive substring match). Send null to require users with no email. | [optional] |
| **statuses** | **Array&lt;String&gt;** | Filter by user status. Returns users matching any of the supplied statuses. | [optional] |
| **created_after** | **Time** | Only return users created at or after this instant (ISO-8601 UTC). | [optional] |
| **created_before** | **Time** | Only return users created at or before this instant (ISO-8601 UTC). | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerUserSearchRequest.new(
  name: Ada,
  email: @example.com,
  statuses: null,
  created_after: 2026-01-01T00:00:00Z,
  created_before: 2026-12-31T23:59:59Z
)
```

