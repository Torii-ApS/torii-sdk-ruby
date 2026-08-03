# ToriiBackendGenerated::ServerUserSearchRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Filter by name (case-insensitive substring match). Send null to require users with no name. | [optional] |
| **user_ids** | **Array&lt;String&gt;** | Restrict to these user ids (the explicit batch-by-id lookup), at most 100. AND-combined with the other id-selectors; an empty list returns an empty page. | [optional] |
| **email_addresses** | **Array&lt;String&gt;** | Resolve users by exact (case-insensitive) email address (one or more, at most 100). Unlike &#x60;email&#x60;, never matches a superstring. AND-combined with the other id-selectors; an empty list, or addresses matching nobody, returns an empty page. | [optional] |
| **email** | **String** | Filter by primary email (case-insensitive substring match). AND-combined with the other id-selectors. An explicit null or blank value contributes no restriction. | [optional] |
| **statuses** | **Array&lt;String&gt;** | Filter by user status. Returns users matching any of the supplied statuses. | [optional] |
| **created_after** | **Time** | Only return users created at or after this instant (ISO-8601 UTC). | [optional] |
| **created_before** | **Time** | Only return users created at or before this instant (ISO-8601 UTC). | [optional] |
| **organization_id** | **String** | Only return members of this organization. An organization from another environment matches nobody. Not an id-selector: it is applied as a membership semi-join, so it is never capped and always ANDs with the rest of the filters. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerUserSearchRequest.new(
  name: Ada,
  user_ids: [01931a73-8b00-7000-8000-000000000000],
  email_addresses: [ada@example.com],
  email: @example.com,
  statuses: null,
  created_after: 2026-01-01T00:00:00Z,
  created_before: 2026-12-31T23:59:59Z,
  organization_id: 01931a73-8b00-7000-8000-000000000000
)
```

