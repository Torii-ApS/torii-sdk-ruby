# ToriiBackendGenerated::ServerImpersonationApi

All URIs are relative to *https://api.torii.so*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**mint_impersonation_token**](ServerImpersonationApi.md#mint_impersonation_token) | **POST** /api/server/v1/users/{userId}/impersonation-token | Mint an impersonation token |


## mint_impersonation_token

> <ServerImpersonationTokenResponse> mint_impersonation_token(user_id, server_impersonation_token_request)

Mint an impersonation token

Creates a single-use, short-lived impersonation token for the target user, attributed to `actorUserId`. Redeem it programmatically via `POST /_torii/auth/session/impersonate` (access token in the body), or hand the returned `url` to an operator to open in a browser (establishes the session and redirects to the landing URL). Counts against the same per-period impersonation quota and usage ledger as the dashboard.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerImpersonationApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | The user to impersonate.
server_impersonation_token_request = ToriiBackendGenerated::ServerImpersonationTokenRequest.new({actor_user_id: '01931a73-8b00-7000-8000-000000000000', reason: 'Investigating support ticket #4821'}) # ServerImpersonationTokenRequest | 

begin
  # Mint an impersonation token
  result = api_instance.mint_impersonation_token(user_id, server_impersonation_token_request)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerImpersonationApi->mint_impersonation_token: #{e}"
end
```

#### Using the mint_impersonation_token_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ServerImpersonationTokenResponse>, Integer, Hash)> mint_impersonation_token_with_http_info(user_id, server_impersonation_token_request)

```ruby
begin
  # Mint an impersonation token
  data, status_code, headers = api_instance.mint_impersonation_token_with_http_info(user_id, server_impersonation_token_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ServerImpersonationTokenResponse>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerImpersonationApi->mint_impersonation_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | The user to impersonate. |  |
| **server_impersonation_token_request** | [**ServerImpersonationTokenRequest**](ServerImpersonationTokenRequest.md) |  |  |

### Return type

[**ServerImpersonationTokenResponse**](ServerImpersonationTokenResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/problem+json

