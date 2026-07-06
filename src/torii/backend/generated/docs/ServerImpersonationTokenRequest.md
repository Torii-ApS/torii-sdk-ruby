# ToriiBackendGenerated::ServerImpersonationTokenRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **actor_user_id** | **String** | The principal the impersonation is on behalf of (recorded for accountability). Must be a user in this environment. |  |
| **reason** | **String** | Mandatory justification (GDPR purpose limitation); recorded in the audit log on mint and redeem. |  |
| **redirect_url** | **String** | Optional post-redeem landing URL for the &#x60;url&#x60; redeem link; its origin must be in the environment&#39;s allowed origins. Omit to default to the environment&#39;s first non-wildcard allowed origin. | [optional] |
| **expires_in_seconds** | **Integer** | Optional token lifetime in seconds, 60..600. Omit for the 600s default. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerImpersonationTokenRequest.new(
  actor_user_id: 01931a73-8b00-7000-8000-000000000000,
  reason: Investigating support ticket #4821,
  redirect_url: https://app.example.com/dashboard,
  expires_in_seconds: 600
)
```

