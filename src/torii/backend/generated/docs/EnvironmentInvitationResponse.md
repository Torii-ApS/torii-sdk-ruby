# ToriiBackendGenerated::EnvironmentInvitationResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** |  |  |
| **environment_id** | **String** |  |  |
| **email** | **String** |  |  |
| **status** | **String** |  |  |
| **expires_at** | **Time** |  |  |
| **created_at** | **Time** |  |  |
| **accepted_at** | **Time** |  | [optional] |
| **revoked_at** | **Time** |  | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::EnvironmentInvitationResponse.new(
  id: null,
  environment_id: null,
  email: null,
  status: null,
  expires_at: null,
  created_at: null,
  accepted_at: null,
  revoked_at: null
)
```

