# ToriiBackendGenerated::EnvironmentInvitationDetailResponse

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
| **public_metadata** | **Hash&lt;String, Object&gt;** |  |  |
| **private_metadata** | **Hash&lt;String, Object&gt;** |  |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::EnvironmentInvitationDetailResponse.new(
  id: null,
  environment_id: null,
  email: null,
  status: null,
  expires_at: null,
  created_at: null,
  accepted_at: null,
  revoked_at: null,
  public_metadata: null,
  private_metadata: null
)
```

