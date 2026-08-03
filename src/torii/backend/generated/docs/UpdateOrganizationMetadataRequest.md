# ToriiBackendGenerated::UpdateOrganizationMetadataRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **public_metadata** | **Hash&lt;String, Object&gt;** | Public metadata bag. An organization&#39;s bag is readable over the client API by any member; a MEMBERSHIP&#39;s bags are server-plane only and are never returned on a client-facing read. Capped at 8 KB on its own. | [optional] |
| **private_metadata** | **Hash&lt;String, Object&gt;** | Private metadata bag: server-only. Never exposed to the SDK, never in a JWT. Capped at 8 KB on its own. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::UpdateOrganizationMetadataRequest.new(
  public_metadata: {plan&#x3D;enterprise},
  private_metadata: {crmAccountId&#x3D;acct_123}
)
```

