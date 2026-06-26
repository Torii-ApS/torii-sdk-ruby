# ToriiBackendGenerated::CreateUserRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **email** | **String** | Primary email for the new user. If omitted, the user is created without a sign-in identity. | [optional] |
| **password** | **String** | Initial password. Subject to the environment&#39;s password policy. Omit to create a passwordless user (e.g. social-only). | [optional] |
| **first_name** | **String** | First (given) name to seed on the profile. | [optional] |
| **last_name** | **String** | Last (family) name to seed on the profile. | [optional] |
| **public_metadata** | **Hash&lt;String, Object&gt;** | Initial public metadata (SDK-readable, server-written). Max 512 bytes. |  |
| **private_metadata** | **Hash&lt;String, Object&gt;** | Initial private metadata (server-only). Max 4096 bytes. |  |
| **unsafe_metadata** | **Hash&lt;String, Object&gt;** | Initial unsafe metadata (end-user writable). Max 512 bytes. |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::CreateUserRequest.new(
  email: ada@example.com,
  password: correct horse battery staple,
  first_name: Ada,
  last_name: Lovelace,
  public_metadata: {plan&#x3D;free},
  private_metadata: {stripeId&#x3D;cus_123},
  unsafe_metadata: {onboardingStep&#x3D;0}
)
```

