# ToriiBackendGenerated::ServerOrganizationMemberResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **organization_id** | **String** |  |  |
| **user_id** | **String** |  |  |
| **role** | **String** |  |  |
| **role_name** | **String** |  | [optional] |
| **public_metadata** | **Hash&lt;String, Object&gt;** |  |  |
| **private_metadata** | **Hash&lt;String, Object&gt;** |  |  |
| **joined_at** | **Time** |  |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerOrganizationMemberResponse.new(
  organization_id: null,
  user_id: null,
  role: null,
  role_name: null,
  public_metadata: null,
  private_metadata: null,
  joined_at: null
)
```

