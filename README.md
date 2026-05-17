# torii-backend (Ruby)

Backend SDK for [torii](https://torii.so) — verify end-user JWTs without a per-request round trip and manage users from your Ruby server.

> **v0.x — API may still change.**

## Setup

1. Sign in to [app.torii.so](https://app.torii.so) and from your dashboard copy:
   - your **issuer URL** (e.g. `https://acme.torii.so`)
   - a **secret key** (`sk_test_…` for development, `sk_live_…` for production)

2. Install the gem:

   ```sh
   gem install torii-backend
   ```

   or in your `Gemfile`:

   ```ruby
   gem 'torii-backend'
   ```

   Requires Ruby 3.1+.

3. Verify an end-user JWT:

   ```ruby
   require 'torii/backend'

   auth = Torii::Backend.verify_token(token, issuer: 'https://acme.torii.so')
   auth.user_id          # => "user_abc"
   auth.environment_id   # => "env_xyz"
   auth.email_verified   # => true
   ```

   The first call fetches the issuer's JWKS at `{issuer}/_torii/.well-known/jwks.json`; subsequent calls reuse a process-wide cache (5-minute TTL, automatic refresh on `kid` miss). ES256 only.

4. Call the backend REST API:

   ```ruby
   torii = Torii::Backend::Client.new(secret_key: ENV.fetch('TORII_SECRET_KEY'))
   user = torii.users.get(user_id)
   ```

   Default base URL is `https://api.torii.so`. Override with `api_url:` for staging or self-hosted.

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
page = torii.users.list(limit: 50)
page[:items]        # => [{ id: "...", ... }, ...]
page[:next_cursor]  # => "cursor_..." or nil
page[:has_more]     # => true / false

user = torii.users.create(email: 'x@y.com')
torii.users.update(user[:id], name: Torii::Backend::Patch.set('New name'))
torii.users.ban(user[:id])

sessions = torii.sessions.list_for_user(user[:id])
torii.sessions.revoke_all_for_user(user[:id])
```

The REST client is generated from the OpenAPI spec at `spec/server-v1.json` via [openapi-generator-cli](https://openapi-generator.tech/) (target: `ruby`); hand-written wrappers in `lib/torii/backend/client.rb` give it the Ruby-idiomatic surface above.

### Partial updates

PATCH fields are tri-state: set to a value, clear (JSON null on the wire), or leave alone. Ruby keyword args can't express that on their own (a literal `nil` can't be told apart from "absent"), so every kwarg accepted by `update` must be wrapped in `Torii::Backend::Patch`:

```ruby
torii.users.update(user_id,
  name: Torii::Backend::Patch.set('New name'),  # update the name
  phone: Torii::Backend::Patch.set(nil),        # null on the wire
  # locale, address, date_of_birth omitted -> untouched
)
```

`Patch.set(value)` updates the field; `Patch.set(nil)` clears it; omitted kwargs are left untouched on the server.

## Errors

* `Torii::Backend::Error` — base.
* `Torii::Backend::AuthError` — raised by `verify_token` / `authenticate_request`.
* `Torii::Backend::ApiError` — raised by REST calls on non-2xx. Inspect `status`, `code`, `support_id`, `body`.

## License

MIT
