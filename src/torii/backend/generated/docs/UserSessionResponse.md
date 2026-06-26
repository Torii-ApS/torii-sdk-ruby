# ToriiBackendGenerated::UserSessionResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Unique identifier for this session. |  |
| **user_id** | **String** | Identifier of the end-user this session belongs to. |  |
| **environment_id** | **String** | Identifier of the environment this session belongs to. |  |
| **user_agent** | **String** | Raw User-Agent string captured when the session was created. | [optional] |
| **ip_address** | **String** | IP address captured when the session was created. | [optional] |
| **created_at** | **Time** | When this session was created (ISO-8601 UTC). |  |
| **expires_at** | **Time** | When this session expires (ISO-8601 UTC). |  |
| **last_used_at** | **Time** | When this session was last seen by the API (ISO-8601 UTC). |  |
| **active_organization_id** | **String** | Active organization pinned to this session (&#x60;org_id&#x60; claim on re-mint). | [optional] |
| **impersonated_by** | **String** | Platform user behind this session when it was established via impersonation; null for normal sign-ins. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::UserSessionResponse.new(
  id: 01931a74-1234-7000-8000-000000000000,
  user_id: 01931a73-8b00-7000-8000-000000000000,
  environment_id: 01931a72-0000-7000-8000-000000000000,
  user_agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14_6_0) AppleWebKit/537.36,
  ip_address: 203.0.113.42,
  created_at: 2026-05-16T09:30:00Z,
  expires_at: 2026-05-23T09:30:00Z,
  last_used_at: 2026-05-16T11:42:00Z,
  active_organization_id: null,
  impersonated_by: null
)
```

