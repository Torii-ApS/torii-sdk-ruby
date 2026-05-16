# torii-backend (Ruby)

Backend SDK for [torii](https://torii.so) — verify end-user JWTs without a per-request round trip, manage users from your Ruby server, and (soon) react to events from torii.

> **Status: 0.0.x preview.** Stable for verify + users + sessions. Outbound webhooks (`verify_webhook`) is a stub that raises until torii's webhook subsystem ships (tracked in [#424](https://github.com/GOOD-Code-ApS/torii/issues/424) Phase 0.5).

Requires **Ruby 3.1+**.

## Install

```sh
gem install torii-backend
```

or in your `Gemfile`:

```ruby
gem 'torii-backend'
```

## Verify a JWT

```ruby
require 'torii/backend'

auth = Torii::Backend.verify_token(token, issuer: 'https://acme.torii.so')
auth.user_id          # => "user_abc"
auth.environment_id   # => "env_xyz"
auth.email_verified   # => true
```

The first call fetches the issuer's JWKS at `{issuer}/_torii/.well-known/jwks.json`; subsequent calls reuse a process-wide cache (5-minute TTL, automatic refresh on `kid` miss). ES256 only.

## Rack middleware (Rails / Sinatra / Roda)

```ruby
# config/application.rb (Rails)
config.middleware.use Torii::Backend::Rack::RequireAuth,
  issuer: 'https://acme.torii.so'
```

```ruby
# config.ru (Sinatra / plain Rack)
use Torii::Backend::Rack::RequireAuth, issuer: 'https://acme.torii.so'
run MyApp
```

On success the verified `Torii::Backend::Auth` is placed at `env['torii.auth']`. On failure the middleware short-circuits with a `401` JSON body:

```json
{ "error": { "code": "authentication_failed", "message": "..." } }
```

For ad-hoc verification outside Rack:

```ruby
auth = Torii::Backend.authenticate_request(
  request.env,
  issuer: 'https://acme.torii.so',
)
```

`authenticate_request` accepts a Rack `env`, a plain `Hash` of headers (string or symbol keys), or anything that responds to `#each` with `[name, value]` pairs.

## Backend API (REST client)

```ruby
torii = Torii::Backend::Client.new(secret_key: ENV.fetch('TORII_SECRET_KEY'))

page = torii.users.list(limit: 50)
page[:items]        # => [{ id: "...", ... }, ...]
page[:next_cursor]  # => "cursor_..." or nil
page[:has_more]     # => true / false

user = torii.users.create(email: 'x@y.com')
torii.users.update(user[:id], name: 'New name')
torii.users.ban(user[:id])

sessions = torii.sessions.list_for_user(user[:id])
torii.sessions.revoke_all_for_user(user[:id])
```

The REST client is generated from the OpenAPI spec at `spec/server-v1.json` via [openapi-generator-cli](https://openapi-generator.tech/) (target: `ruby`); hand-written wrappers in `lib/torii/backend/client.rb` give it the Ruby-idiomatic surface above. Default base URL is `https://api.torii.so`. Override with `api_url:` for staging or self-hosted.

### Partial updates

`update` uses a sentinel — `Torii::Backend::OMIT` — to distinguish "leave this field untouched" from "clear this field":

```ruby
torii.users.update(user_id, name: 'New name')          # leaves phone untouched
torii.users.update(user_id, phone: nil)                # clears phone
torii.users.update(user_id, phone: Torii::Backend::OMIT) # also leaves phone untouched
```

## Verify outbound webhooks

```ruby
# Currently raises — preserved here so adopting it later doesn't break callers.
Torii::Backend.verify_webhook(secret: secret, headers: headers, payload: body)
```

## Errors

* `Torii::Backend::Error` — base.
* `Torii::Backend::AuthError` — raised by `verify_token` / `authenticate_request` / `verify_webhook`.
* `Torii::Backend::ApiError` — raised by REST calls on non-2xx. Inspect `status`, `code`, `support_id`, `body`.

## License

MIT
