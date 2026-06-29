# ToriiBackendGenerated::UpdateUserMetadataRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **public_metadata** | **Hash&lt;String, Object&gt;** | Public metadata bag: SDK-readable, server-written. Part of the 8 KB combined metadata budget. | [optional] |
| **private_metadata** | **Hash&lt;String, Object&gt;** | Private metadata bag: server-only, never exposed to the SDK or in a JWT. Part of the 8 KB combined metadata budget. | [optional] |
| **unsafe_metadata** | **Hash&lt;String, Object&gt;** | Unsafe metadata bag: readable and writable by the end-user via the SDK. Part of the 8 KB combined metadata budget. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::UpdateUserMetadataRequest.new(
  public_metadata: {plan&#x3D;pro},
  private_metadata: {billingCustomerId&#x3D;cus_123},
  unsafe_metadata: {onboardingStep&#x3D;2}
)
```

