# ToriiBackendGenerated::AllowedOriginsApi

All URIs are relative to *https://api.toriiauth.eu*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**list**](AllowedOriginsApi.md#list) | **GET** /api/server/v1/allowed-origins | List escape-hatch origins for this environment |
| [**set**](AllowedOriginsApi.md#set) | **PUT** /api/server/v1/allowed-origins | Replace the escape-hatch origins for this environment |


## list

> <AllowedOriginsResponse> list

List escape-hatch origins for this environment

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::AllowedOriginsApi.new

begin
  # List escape-hatch origins for this environment
  result = api_instance.list
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling AllowedOriginsApi->list: #{e}"
end
```

#### Using the list_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AllowedOriginsResponse>, Integer, Hash)> list_with_http_info

```ruby
begin
  # List escape-hatch origins for this environment
  data, status_code, headers = api_instance.list_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AllowedOriginsResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling AllowedOriginsApi->list_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**AllowedOriginsResponse**](AllowedOriginsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## set

> <AllowedOriginsResponse> set(set_allowed_origins_request)

Replace the escape-hatch origins for this environment

Full origins incl. non-http schemes (e.g. capacitor://localhost). Replaces the list.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::AllowedOriginsApi.new
set_allowed_origins_request = ToriiBackendGenerated::SetAllowedOriginsRequest.new({origins: ['origins_example']}) # SetAllowedOriginsRequest | 

begin
  # Replace the escape-hatch origins for this environment
  result = api_instance.set(set_allowed_origins_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling AllowedOriginsApi->set: #{e}"
end
```

#### Using the set_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AllowedOriginsResponse>, Integer, Hash)> set_with_http_info(set_allowed_origins_request)

```ruby
begin
  # Replace the escape-hatch origins for this environment
  data, status_code, headers = api_instance.set_with_http_info(set_allowed_origins_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AllowedOriginsResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling AllowedOriginsApi->set_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **set_allowed_origins_request** | [**SetAllowedOriginsRequest**](SetAllowedOriginsRequest.md) |  |  |

### Return type

[**AllowedOriginsResponse**](AllowedOriginsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

