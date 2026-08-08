# ToriiBackendGenerated::ServerOrganizationsApi

All URIs are relative to *https://api.toriiauth.eu*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_organization**](ServerOrganizationsApi.md#get_organization) | **GET** /api/server/v1/organizations/{organizationId} | Get an organization |
| [**list_members**](ServerOrganizationsApi.md#list_members) | **GET** /api/server/v1/organizations/{organizationId}/members | List organization members |
| [**list_organizations**](ServerOrganizationsApi.md#list_organizations) | **GET** /api/server/v1/organizations | List organizations |
| [**update_member_metadata**](ServerOrganizationsApi.md#update_member_metadata) | **PATCH** /api/server/v1/organizations/{organizationId}/members/{memberUserId}/metadata | Update organization membership metadata |
| [**update_organization_metadata**](ServerOrganizationsApi.md#update_organization_metadata) | **PATCH** /api/server/v1/organizations/{organizationId}/metadata | Update organization metadata |


## get_organization

> <ServerOrganizationResponse> get_organization(organization_id)

Get an organization

One organization with both metadata bags.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerOrganizationsApi.new
organization_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # Get an organization
  result = api_instance.get_organization(organization_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->get_organization: #{e}"
end
```

#### Using the get_organization_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerOrganizationResponse>, Integer, Hash)> get_organization_with_http_info(organization_id)

```ruby
begin
  # Get an organization
  data, status_code, headers = api_instance.get_organization_with_http_info(organization_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerOrganizationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->get_organization_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **organization_id** | **String** |  |  |

### Return type

[**ServerOrganizationResponse**](ServerOrganizationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## list_members

> <CursorPageResponseServerOrganizationMemberResponse> list_members(organization_id, opts)

List organization members

Cursor-paginated page of the organization's USER memberships, each with both metadata bags. Ordered by member user id ascending (a creation-ordered uuid v7, which is also the seek key), NOT by join time.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerOrganizationsApi.new
organization_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
opts = {
  limit: 50, # Integer | Maximum number of items in the returned page (default 20; values outside 1-100 are clamped).
  cursor: '01931a73-8b00-7000-8000-000000000000' # String | Opaque cursor returned by the previous page's `nextCursor`. Omit to fetch the first page.
}

begin
  # List organization members
  result = api_instance.list_members(organization_id, opts)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->list_members: #{e}"
end
```

#### Using the list_members_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CursorPageResponseServerOrganizationMemberResponse>, Integer, Hash)> list_members_with_http_info(organization_id, opts)

```ruby
begin
  # List organization members
  data, status_code, headers = api_instance.list_members_with_http_info(organization_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CursorPageResponseServerOrganizationMemberResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->list_members_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **organization_id** | **String** |  |  |
| **limit** | **Integer** | Maximum number of items in the returned page (default 20; values outside 1-100 are clamped). | [optional][default to 20] |
| **cursor** | **String** | Opaque cursor returned by the previous page&#39;s &#x60;nextCursor&#x60;. Omit to fetch the first page. | [optional] |

### Return type

[**CursorPageResponseServerOrganizationMemberResponse**](CursorPageResponseServerOrganizationMemberResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## list_organizations

> <CursorPageResponseServerOrganizationResponse> list_organizations(opts)

List organizations

Cursor-paginated page of the environment's organizations, with both metadata bags. Optional `name` filter is a case-insensitive substring match.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerOrganizationsApi.new
opts = {
  name: 'acme', # String | Case-insensitive substring filter on the organization name.
  limit: 50, # Integer | Maximum number of items in the returned page (default 20; values outside 1-100 are clamped).
  cursor: '01931a73-8b00-7000-8000-000000000000' # String | Opaque cursor returned by the previous page's `nextCursor`. Omit to fetch the first page.
}

begin
  # List organizations
  result = api_instance.list_organizations(opts)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->list_organizations: #{e}"
end
```

#### Using the list_organizations_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CursorPageResponseServerOrganizationResponse>, Integer, Hash)> list_organizations_with_http_info(opts)

```ruby
begin
  # List organizations
  data, status_code, headers = api_instance.list_organizations_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CursorPageResponseServerOrganizationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->list_organizations_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Case-insensitive substring filter on the organization name. | [optional] |
| **limit** | **Integer** | Maximum number of items in the returned page (default 20; values outside 1-100 are clamped). | [optional][default to 20] |
| **cursor** | **String** | Opaque cursor returned by the previous page&#39;s &#x60;nextCursor&#x60;. Omit to fetch the first page. | [optional] |

### Return type

[**CursorPageResponseServerOrganizationResponse**](CursorPageResponseServerOrganizationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## update_member_metadata

> <ServerOrganizationMemberResponse> update_member_metadata(organization_id, member_user_id, update_organization_metadata_request)

Update organization membership metadata

Deep-merges into either bag on one membership, with the same tri-state contract as the organization endpoint. Each bag on the membership has its own 8 KB budget, separate from the organization's bags.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerOrganizationsApi.new
organization_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
member_user_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
update_organization_metadata_request = ToriiBackendGenerated::UpdateOrganizationMetadataRequest.new # UpdateOrganizationMetadataRequest | 

begin
  # Update organization membership metadata
  result = api_instance.update_member_metadata(organization_id, member_user_id, update_organization_metadata_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->update_member_metadata: #{e}"
end
```

#### Using the update_member_metadata_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerOrganizationMemberResponse>, Integer, Hash)> update_member_metadata_with_http_info(organization_id, member_user_id, update_organization_metadata_request)

```ruby
begin
  # Update organization membership metadata
  data, status_code, headers = api_instance.update_member_metadata_with_http_info(organization_id, member_user_id, update_organization_metadata_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerOrganizationMemberResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->update_member_metadata_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **organization_id** | **String** |  |  |
| **member_user_id** | **String** |  |  |
| **update_organization_metadata_request** | [**UpdateOrganizationMetadataRequest**](UpdateOrganizationMetadataRequest.md) |  |  |

### Return type

[**ServerOrganizationMemberResponse**](ServerOrganizationMemberResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json


## update_organization_metadata

> <ServerOrganizationResponse> update_organization_metadata(organization_id, update_organization_metadata_request)

Update organization metadata

Deep-merges into either metadata bag. Each bag is tri-state: omit the key to leave the bag unchanged, or send an object to deep-merge into it (a key set to null removes it). Each bag is capped at 8 KB on its own, measured on the merged result rather than on the patch you send. A request naming neither bag is a 400.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerOrganizationsApi.new
organization_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
update_organization_metadata_request = ToriiBackendGenerated::UpdateOrganizationMetadataRequest.new # UpdateOrganizationMetadataRequest | 

begin
  # Update organization metadata
  result = api_instance.update_organization_metadata(organization_id, update_organization_metadata_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->update_organization_metadata: #{e}"
end
```

#### Using the update_organization_metadata_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerOrganizationResponse>, Integer, Hash)> update_organization_metadata_with_http_info(organization_id, update_organization_metadata_request)

```ruby
begin
  # Update organization metadata
  data, status_code, headers = api_instance.update_organization_metadata_with_http_info(organization_id, update_organization_metadata_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerOrganizationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerOrganizationsApi->update_organization_metadata_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **organization_id** | **String** |  |  |
| **update_organization_metadata_request** | [**UpdateOrganizationMetadataRequest**](UpdateOrganizationMetadataRequest.md) |  |  |

### Return type

[**ServerOrganizationResponse**](ServerOrganizationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json

