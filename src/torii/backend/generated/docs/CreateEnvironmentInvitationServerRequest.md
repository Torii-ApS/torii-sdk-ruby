# ToriiBackendGenerated::CreateEnvironmentInvitationServerRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **email** | **String** |  |  |
| **expires_in_days** | **Integer** |  | [optional] |
| **redirect_url** | **String** |  | [optional] |
| **public_metadata** | **Hash&lt;String, Object&gt;** |  |  |
| **private_metadata** | **Hash&lt;String, Object&gt;** |  |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::CreateEnvironmentInvitationServerRequest.new(
  email: null,
  expires_in_days: null,
  redirect_url: null,
  public_metadata: null,
  private_metadata: null
)
```

