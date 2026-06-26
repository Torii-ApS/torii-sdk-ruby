# ToriiBackendGenerated::UpdateUserRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **first_name** | **String** | New first (given) name. Send null to clear; omit to leave unchanged. | [optional] |
| **last_name** | **String** | New last (family) name. Send null to clear; omit to leave unchanged. | [optional] |
| **locale** | **String** | New preferred locale. Send null to clear; omit to leave unchanged. | [optional] |
| **unsafe_metadata** | **Hash&lt;String, Object&gt;** | Deep-merges into the user&#39;s unsafe metadata (a key set to null removes it); omit to leave unchanged. Merged result max 512 bytes. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::UpdateUserRequest.new(
  first_name: Ada,
  last_name: Lovelace,
  locale: null,
  unsafe_metadata: {onboardingStep&#x3D;2}
)
```

