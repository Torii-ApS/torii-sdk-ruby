# ToriiBackendGenerated::CursorPageResponseServerOrganizationMemberResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **items** | [**Array&lt;ServerOrganizationMemberResponse&gt;**](ServerOrganizationMemberResponse.md) | Items in this page, in stable order. |  |
| **next_cursor** | **String** | Cursor to pass to fetch the next page. Null when this is the last page. | [optional] |
| **has_more** | **Boolean** | True if more pages are available (equivalent to &#x60;nextCursor !&#x3D; null&#x60;). |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::CursorPageResponseServerOrganizationMemberResponse.new(
  items: null,
  next_cursor: 01931a73-8b00-7000-8000-000000000000,
  has_more: true
)
```

