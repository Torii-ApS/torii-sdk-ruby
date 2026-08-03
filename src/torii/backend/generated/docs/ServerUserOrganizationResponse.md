# ToriiBackendGenerated::ServerUserOrganizationResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **organization_id** | **String** |  |  |
| **name** | **String** | The organization&#39;s display name. |  |
| **slug** | **String** | The organization&#39;s slug, when it has one. | [optional] |
| **role** | **String** | This user&#39;s role key in the organization (e.g. org:administrator). |  |
| **role_name** | **String** | Display name of that role, from the organization&#39;s bound role set. Null when the organization has no bound set or the key is not in it. | [optional] |
| **public_metadata** | **Hash&lt;String, Object&gt;** | The MEMBERSHIP&#39;s public metadata bag, not the organization&#39;s. |  |
| **private_metadata** | **Hash&lt;String, Object&gt;** | The MEMBERSHIP&#39;s private metadata bag, not the organization&#39;s. Server-only, never exposed to the SDK. |  |
| **joined_at** | **Time** |  |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerUserOrganizationResponse.new(
  organization_id: null,
  name: null,
  slug: null,
  role: null,
  role_name: null,
  public_metadata: {seat&#x3D;billable},
  private_metadata: {crmContactId&#x3D;con_123},
  joined_at: null
)
```

