# ToriiBackendGenerated::UpdateUserMetadataRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **public_metadata** | **Hash&lt;String, Object&gt;** | Public metadata bag: SDK-readable, server-written. Max 512 bytes. | [optional] |
| **private_metadata** | **Hash&lt;String, Object&gt;** | Private metadata bag: server-only, never exposed to the SDK or in a JWT. Max 4096 bytes. | [optional] |
| **unsafe_metadata** | **Hash&lt;String, Object&gt;** | Unsafe metadata bag: readable and writable by the end-user via the SDK. Max 512 bytes. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::UpdateUserMetadataRequest.new(
  public_metadata: {plan&#x3D;pro},
  private_metadata: {stripeId&#x3D;cus_123},
  unsafe_metadata: {onboardingStep&#x3D;2}
)
```

