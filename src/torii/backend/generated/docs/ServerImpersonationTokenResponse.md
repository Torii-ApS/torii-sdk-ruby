# ToriiBackendGenerated::ServerImpersonationTokenResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **token** | **String** | The single-use token. Redeem via POST /_torii/auth/session/impersonate. |  |
| **expires_in_seconds** | **Integer** | The token&#39;s lifetime in seconds (the resolved value after any override). |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerImpersonationTokenResponse.new(
  token: null,
  expires_in_seconds: 60
)
```

