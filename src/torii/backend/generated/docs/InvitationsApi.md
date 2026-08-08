# ToriiBackendGenerated::InvitationsApi

All URIs are relative to *https://api.toriiauth.eu*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create**](InvitationsApi.md#create) | **POST** /api/server/v1/invitations | Create an invitation with optional pre-seeded metadata |
| [**get**](InvitationsApi.md#get) | **GET** /api/server/v1/invitations/{invitationId} | Get an invitation by id |
| [**list1**](InvitationsApi.md#list1) | **GET** /api/server/v1/invitations | List invitations for this environment |
| [**resend**](InvitationsApi.md#resend) | **POST** /api/server/v1/invitations/{invitationId}/resend | Resend a pending invitation with a fresh link |
| [**revoke**](InvitationsApi.md#revoke) | **DELETE** /api/server/v1/invitations/{invitationId} | Revoke a pending invitation |


## create

> <EnvironmentInvitationResponse> create(create_environment_invitation_server_request)

Create an invitation with optional pre-seeded metadata

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::InvitationsApi.new
create_environment_invitation_server_request = ToriiBackendGenerated::CreateEnvironmentInvitationServerRequest.new({email: 'email_example', public_metadata: { key: 3.56}, private_metadata: { key: 3.56}}) # CreateEnvironmentInvitationServerRequest | 

begin
  # Create an invitation with optional pre-seeded metadata
  result = api_instance.create(create_environment_invitation_server_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->create: #{e}"
end
```

#### Using the create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<EnvironmentInvitationResponse>, Integer, Hash)> create_with_http_info(create_environment_invitation_server_request)

```ruby
begin
  # Create an invitation with optional pre-seeded metadata
  data, status_code, headers = api_instance.create_with_http_info(create_environment_invitation_server_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <EnvironmentInvitationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->create_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_environment_invitation_server_request** | [**CreateEnvironmentInvitationServerRequest**](CreateEnvironmentInvitationServerRequest.md) |  |  |

### Return type

[**EnvironmentInvitationResponse**](EnvironmentInvitationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json


## get

> <EnvironmentInvitationResponse> get(invitation_id)

Get an invitation by id

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::InvitationsApi.new
invitation_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # Get an invitation by id
  result = api_instance.get(invitation_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->get: #{e}"
end
```

#### Using the get_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<EnvironmentInvitationResponse>, Integer, Hash)> get_with_http_info(invitation_id)

```ruby
begin
  # Get an invitation by id
  data, status_code, headers = api_instance.get_with_http_info(invitation_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <EnvironmentInvitationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->get_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **invitation_id** | **String** |  |  |

### Return type

[**EnvironmentInvitationResponse**](EnvironmentInvitationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list1

> <CursorPageResponseEnvironmentInvitationResponse> list1(opts)

List invitations for this environment

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::InvitationsApi.new
opts = {
  status: ['inner_example'], # Array<String> | 
  search: 'search_example', # String | 
  limit: 56, # Integer | 
  cursor: '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
}

begin
  # List invitations for this environment
  result = api_instance.list1(opts)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->list1: #{e}"
end
```

#### Using the list1_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CursorPageResponseEnvironmentInvitationResponse>, Integer, Hash)> list1_with_http_info(opts)

```ruby
begin
  # List invitations for this environment
  data, status_code, headers = api_instance.list1_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CursorPageResponseEnvironmentInvitationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->list1_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **search** | **String** |  | [optional] |
| **limit** | **Integer** |  | [optional][default to 20] |
| **cursor** | **String** |  | [optional] |

### Return type

[**CursorPageResponseEnvironmentInvitationResponse**](CursorPageResponseEnvironmentInvitationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## resend

> <EnvironmentInvitationResponse> resend(invitation_id)

Resend a pending invitation with a fresh link

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::InvitationsApi.new
invitation_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # Resend a pending invitation with a fresh link
  result = api_instance.resend(invitation_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->resend: #{e}"
end
```

#### Using the resend_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<EnvironmentInvitationResponse>, Integer, Hash)> resend_with_http_info(invitation_id)

```ruby
begin
  # Resend a pending invitation with a fresh link
  data, status_code, headers = api_instance.resend_with_http_info(invitation_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <EnvironmentInvitationResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->resend_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **invitation_id** | **String** |  |  |

### Return type

[**EnvironmentInvitationResponse**](EnvironmentInvitationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## revoke

> revoke(invitation_id)

Revoke a pending invitation

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::InvitationsApi.new
invitation_id = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # Revoke a pending invitation
  api_instance.revoke(invitation_id)
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->revoke: #{e}"
end
```

#### Using the revoke_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> revoke_with_http_info(invitation_id)

```ruby
begin
  # Revoke a pending invitation
  data, status_code, headers = api_instance.revoke_with_http_info(invitation_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling InvitationsApi->revoke_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **invitation_id** | **String** |  |  |

### Return type

nil (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined

