# ToriiBackendGenerated::UpdateEnvironmentInvitationMetadataRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **public_metadata** | **Hash&lt;String, Object&gt;** | Deep-merged into the invitation&#39;s public metadata. A key set to null is removed. | [optional] |
| **private_metadata** | **Hash&lt;String, Object&gt;** | Deep-merged into the invitation&#39;s private metadata. A key set to null is removed. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::UpdateEnvironmentInvitationMetadataRequest.new(
  public_metadata: {tenantId&#x3D;acme},
  private_metadata: {internalRef&#x3D;CRM-42}
)
```

