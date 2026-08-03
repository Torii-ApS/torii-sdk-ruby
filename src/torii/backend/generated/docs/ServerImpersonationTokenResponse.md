# ToriiBackendGenerated::ServerImpersonationTokenResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **token** | **String** | The single-use token. Redeem via POST /_torii/auth/session/impersonate, or hand the ready-to-use &#x60;url&#x60; to an operator. |  |
| **expires_in_seconds** | **Integer** | The token&#39;s lifetime in seconds (the resolved value after any override). |  |
| **url** | **String** | A ready-to-use, navigable redeem link on the environment&#39;s Frontend API host. Opening it in a browser establishes the impersonated session and redirects to the landing URL. Backed by the same single-use token. Null when no landing URL could be resolved: no &#x60;redirectUrl&#x60; given and the environment has no concrete allowed origin other than the hosted portal&#39;s own — redeem the &#x60;token&#x60; via POST instead. | [optional] |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerImpersonationTokenResponse.new(
  token: null,
  expires_in_seconds: 600,
  url: https://auth.example.com/_torii/auth/session/impersonate?token&#x3D;…
)
```

