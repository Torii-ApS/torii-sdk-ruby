# ToriiBackendGenerated::ServerUsersApi

All URIs are relative to *https://api.torii.so*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**ban_user**](ServerUsersApi.md#ban_user) | **POST** /api/server/v1/users/{userId}/ban | Ban user |
| [**create_user**](ServerUsersApi.md#create_user) | **POST** /api/server/v1/users | Create user |
| [**delete_user**](ServerUsersApi.md#delete_user) | **DELETE** /api/server/v1/users/{userId} | Delete user |
| [**get_user**](ServerUsersApi.md#get_user) | **GET** /api/server/v1/users/{userId} | Get user |
| [**list_user_organizations**](ServerUsersApi.md#list_user_organizations) | **GET** /api/server/v1/users/{userId}/organizations | List a user&#39;s organizations |
| [**search_users**](ServerUsersApi.md#search_users) | **POST** /api/server/v1/users/search | Search users |
| [**unban_user**](ServerUsersApi.md#unban_user) | **POST** /api/server/v1/users/{userId}/unban | Unban user |
| [**update_user**](ServerUsersApi.md#update_user) | **PATCH** /api/server/v1/users/{userId} | Update user |
| [**update_user_metadata**](ServerUsersApi.md#update_user_metadata) | **PATCH** /api/server/v1/users/{userId}/metadata | Update user metadata |


## ban_user

> <ServerUserResponse> ban_user(user_id)

Ban user

Marks the user as banned and revokes all their active sessions.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user to ban.

begin
  # Ban user
  result = api_instance.ban_user(user_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->ban_user: #{e}"
end
```

#### Using the ban_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerUserResponse>, Integer, Hash)> ban_user_with_http_info(user_id)

```ruby
begin
  # Ban user
  data, status_code, headers = api_instance.ban_user_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->ban_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user to ban. |  |

### Return type

[**ServerUserResponse**](ServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## create_user

> <ServerUserResponse> create_user(create_user_request)

Create user

Creates an end-user in your environment. All body fields are optional; supply at minimum an email if you want the user to be able to sign in via email + password.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
create_user_request = ToriiBackendGenerated::CreateUserRequest.new # CreateUserRequest | 

begin
  # Create user
  result = api_instance.create_user(create_user_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->create_user: #{e}"
end
```

#### Using the create_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerUserResponse>, Integer, Hash)> create_user_with_http_info(create_user_request)

```ruby
begin
  # Create user
  data, status_code, headers = api_instance.create_user_with_http_info(create_user_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->create_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_user_request** | [**CreateUserRequest**](CreateUserRequest.md) |  |  |

### Return type

[**ServerUserResponse**](ServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json


## delete_user

> delete_user(user_id)

Delete user

Soft-deletes the user. Not idempotent at the HTTP layer: the authorization grant for the user is revoked on the first successful delete, so a subsequent DELETE for the same id returns 403 rather than 204. Treat 403 from a retry as a confirmation that the user is already deleted.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user to delete.

begin
  # Delete user
  api_instance.delete_user(user_id)
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->delete_user: #{e}"
end
```

#### Using the delete_user_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_user_with_http_info(user_id)

```ruby
begin
  # Delete user
  data, status_code, headers = api_instance.delete_user_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->delete_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user to delete. |  |

### Return type

nil (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/problem+json


## get_user

> <ServerUserResponse> get_user(user_id)

Get user

Returns the full profile for one end-user.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user to fetch.

begin
  # Get user
  result = api_instance.get_user(user_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->get_user: #{e}"
end
```

#### Using the get_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerUserResponse>, Integer, Hash)> get_user_with_http_info(user_id)

```ruby
begin
  # Get user
  data, status_code, headers = api_instance.get_user_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->get_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user to fetch. |  |

### Return type

[**ServerUserResponse**](ServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## list_user_organizations

> <CursorPageResponseServerUserOrganizationResponse> list_user_organizations(user_id, opts)

List a user's organizations

Returns a cursor-paginated page of the organizations this user is a member of, with the user's role in each and that membership's metadata bags. The mirror image of listing an organization's members. Note the bags are the MEMBERSHIP's, not the organization's: read the organization itself for those.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user whose organizations to list.
opts = {
  limit: 50, # Integer | Maximum number of items in the returned page (default 20).
  cursor: '01931a73-8b00-7000-8000-000000000000' # String | Opaque cursor returned by the previous page's `nextCursor`. Omit to fetch the first page.
}

begin
  # List a user's organizations
  result = api_instance.list_user_organizations(user_id, opts)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->list_user_organizations: #{e}"
end
```

#### Using the list_user_organizations_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CursorPageResponseServerUserOrganizationResponse>, Integer, Hash)> list_user_organizations_with_http_info(user_id, opts)

```ruby
begin
  # List a user's organizations
  data, status_code, headers = api_instance.list_user_organizations_with_http_info(user_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CursorPageResponseServerUserOrganizationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->list_user_organizations_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user whose organizations to list. |  |
| **limit** | **Integer** | Maximum number of items in the returned page (default 20). | [optional][default to 20] |
| **cursor** | **String** | Opaque cursor returned by the previous page&#39;s &#x60;nextCursor&#x60;. Omit to fetch the first page. | [optional] |

### Return type

[**CursorPageResponseServerUserOrganizationResponse**](CursorPageResponseServerUserOrganizationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## search_users

> <CursorPageResponseServerUserResponse> search_users(opts)

Search users

Returns a cursor-paginated page of end-users in the environment matching the optional filters. Uses POST so the filter body can be sent without URL-encoding. Three id-selectors resolve users to a set of ids (`userIds`, the explicit batch-by-id lookup; `emailAddresses`, exact and case-insensitive; `email`, a case-insensitive substring); when more than one is supplied they are combined with AND (intersection). The remaining filters (`name`, `statuses`, `createdAfter`/`createdBefore`) apply on top.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
opts = {
  limit: 50, # Integer | Maximum number of items in the returned page (default 20).
  cursor: '01931a73-8b00-7000-8000-000000000000', # String | Opaque cursor returned by the previous page's `nextCursor`. Omit to fetch the first page.
  server_user_search_request: ToriiBackendGenerated::ServerUserSearchRequest.new # ServerUserSearchRequest | 
}

begin
  # Search users
  result = api_instance.search_users(opts)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->search_users: #{e}"
end
```

#### Using the search_users_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CursorPageResponseServerUserResponse>, Integer, Hash)> search_users_with_http_info(opts)

```ruby
begin
  # Search users
  data, status_code, headers = api_instance.search_users_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CursorPageResponseServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->search_users_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **limit** | **Integer** | Maximum number of items in the returned page (default 20). | [optional][default to 20] |
| **cursor** | **String** | Opaque cursor returned by the previous page&#39;s &#x60;nextCursor&#x60;. Omit to fetch the first page. | [optional] |
| **server_user_search_request** | [**ServerUserSearchRequest**](ServerUserSearchRequest.md) |  | [optional] |

### Return type

[**CursorPageResponseServerUserResponse**](CursorPageResponseServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json


## unban_user

> <ServerUserResponse> unban_user(user_id)

Unban user

Reverses a previous ban. The user can sign in again on next request.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user to unban.

begin
  # Unban user
  result = api_instance.unban_user(user_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->unban_user: #{e}"
end
```

#### Using the unban_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerUserResponse>, Integer, Hash)> unban_user_with_http_info(user_id)

```ruby
begin
  # Unban user
  data, status_code, headers = api_instance.unban_user_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->unban_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user to unban. |  |

### Return type

[**ServerUserResponse**](ServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## update_user

> <ServerUserResponse> update_user(user_id, update_user_request)

Update user

Partial update with tri-state PATCH semantics. Every field in `UpdateUserRequest` is tri-state: omit the key to leave the field unchanged, send a non-null value to set it, or send JSON null to clear it.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user to update.
update_user_request = ToriiBackendGenerated::UpdateUserRequest.new # UpdateUserRequest | 

begin
  # Update user
  result = api_instance.update_user(user_id, update_user_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->update_user: #{e}"
end
```

#### Using the update_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerUserResponse>, Integer, Hash)> update_user_with_http_info(user_id, update_user_request)

```ruby
begin
  # Update user
  data, status_code, headers = api_instance.update_user_with_http_info(user_id, update_user_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->update_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user to update. |  |
| **update_user_request** | [**UpdateUserRequest**](UpdateUserRequest.md) |  |  |

### Return type

[**ServerUserResponse**](ServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json


## update_user_metadata

> <ServerUserResponse> update_user_metadata(user_id, update_user_metadata_request)

Update user metadata

Deep-merges into any of the three metadata bags. Each bag is tri-state: omit the key to leave the bag unchanged, or send an object to deep-merge into the existing bag (a key set to null removes it). The merged metadata is capped at 8 KB total across `publicMetadata`, `privateMetadata`, and `unsafeMetadata` combined (no per-bag limit).

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerUsersApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user to update.
update_user_metadata_request = ToriiBackendGenerated::UpdateUserMetadataRequest.new # UpdateUserMetadataRequest | 

begin
  # Update user metadata
  result = api_instance.update_user_metadata(user_id, update_user_metadata_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->update_user_metadata: #{e}"
end
```

#### Using the update_user_metadata_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerUserResponse>, Integer, Hash)> update_user_metadata_with_http_info(user_id, update_user_metadata_request)

```ruby
begin
  # Update user metadata
  data, status_code, headers = api_instance.update_user_metadata_with_http_info(user_id, update_user_metadata_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerUserResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerUsersApi->update_user_metadata_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user to update. |  |
| **update_user_metadata_request** | [**UpdateUserMetadataRequest**](UpdateUserMetadataRequest.md) |  |  |

### Return type

[**ServerUserResponse**](ServerUserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json

