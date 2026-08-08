# ToriiBackendGenerated::ServerSessionsApi

All URIs are relative to *https://api.toriiauth.eu*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**list_sessions**](ServerSessionsApi.md#list_sessions) | **GET** /api/server/v1/users/{userId}/sessions | List user sessions |
| [**revoke_all_sessions**](ServerSessionsApi.md#revoke_all_sessions) | **DELETE** /api/server/v1/users/{userId}/sessions | Revoke all sessions |
| [**revoke_session**](ServerSessionsApi.md#revoke_session) | **DELETE** /api/server/v1/users/{userId}/sessions/{sessionId} | Revoke specific session |


## list_sessions

> <Array<UserSessionResponse>> list_sessions(user_id)

List user sessions

Returns all active (unexpired, unrevoked) sessions for the user, ordered by most recently used.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerSessionsApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user whose sessions to list.

begin
  # List user sessions
  result = api_instance.list_sessions(user_id)
  p result
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerSessionsApi->list_sessions: #{e}"
end
```

#### Using the list_sessions_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<UserSessionResponse>>, Integer, Hash)> list_sessions_with_http_info(user_id)

```ruby
begin
  # List user sessions
  data, status_code, headers = api_instance.list_sessions_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<UserSessionResponse>>
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerSessionsApi->list_sessions_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user whose sessions to list. |  |

### Return type

[**Array&lt;UserSessionResponse&gt;**](UserSessionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/problem+json


## revoke_all_sessions

> revoke_all_sessions(user_id)

Revoke all sessions

Immediately revokes every active session for the user. Idempotent.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerSessionsApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user whose sessions to revoke.

begin
  # Revoke all sessions
  api_instance.revoke_all_sessions(user_id)
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerSessionsApi->revoke_all_sessions: #{e}"
end
```

#### Using the revoke_all_sessions_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> revoke_all_sessions_with_http_info(user_id)

```ruby
begin
  # Revoke all sessions
  data, status_code, headers = api_instance.revoke_all_sessions_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerSessionsApi->revoke_all_sessions_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user whose sessions to revoke. |  |

### Return type

nil (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/problem+json


## revoke_session

> revoke_session(user_id, session_id)

Revoke specific session

Revokes a single session by id. Idempotent: returns 204 even if the session was already revoked or expired.

### Examples

```ruby
require 'time'
require 'torii_backend_generated'
# setup authorization
ToriiBackendGenerated.configure do |config|
  # Configure Bearer authorization: bearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = ToriiBackendGenerated::ServerSessionsApi.new
user_id = '01931a73-8b00-7000-8000-000000000000' # String | Identifier of the user who owns the session.
session_id = '01931a74-1234-7000-8000-000000000000' # String | Identifier of the session to revoke.

begin
  # Revoke specific session
  api_instance.revoke_session(user_id, session_id)
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerSessionsApi->revoke_session: #{e}"
end
```

#### Using the revoke_session_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> revoke_session_with_http_info(user_id, session_id)

```ruby
begin
  # Revoke specific session
  data, status_code, headers = api_instance.revoke_session_with_http_info(user_id, session_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue ToriiBackendGenerated::ApiError => e
  puts "Error when calling ServerSessionsApi->revoke_session_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Identifier of the user who owns the session. |  |
| **session_id** | **String** | Identifier of the session to revoke. |  |

### Return type

nil (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/problem+json

