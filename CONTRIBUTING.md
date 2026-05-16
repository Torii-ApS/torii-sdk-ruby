# Contributing

Thanks for your interest in `torii-backend` (the Ruby SDK for torii)!

## Reporting bugs

Open an issue with:

- The version of `torii-backend` you're using (`bundle info torii-backend` or check your `Gemfile.lock`).
- The Ruby version (`ruby -v`).
- A minimal reproduction — a few lines that exhibit the bug.
- What you expected to happen vs. what actually happened.

For security-sensitive issues (anything that could let an attacker forge or bypass token verification), please email **security@torii.so** instead of filing a public issue.

## Development

```sh
git clone https://github.com/Torii-ApS/torii-sdk-ruby
cd torii-sdk-ruby
bundle install
bundle exec rspec
```

The REST client under `src/torii/backend/generated/` is produced by [`openapi-generator`](https://openapi-generator.tech/) from `spec/server-v1.json` (target: `ruby`, Typhoeus-backed). Don't hand-edit it. To regenerate after a spec update:

```sh
npx -y @openapitools/openapi-generator-cli generate \
  -i spec/server-v1.json -g ruby -o lib/torii/backend/generated \
  --additional-properties=gemName=torii_backend_generated,moduleName=ToriiBackendGenerated
```

The hand-written surface (`verify.rb`, `authenticate_request.rb`, `client.rb`, `auth.rb`, `errors.rb`, `rack.rb`, `webhook.rb`, `version.rb`) is where bug reports and PRs typically land.

## Pull requests

1. Open an issue first for non-trivial changes so we can discuss the shape.
2. Branch off `main`, name it `fix/<short>` or `feat/<short>`.
3. Run `bundle exec rspec` before pushing — CI runs the same suite on Ruby 3.1, 3.2, 3.3, and 3.4.
4. Keep PRs small and focused. One concern per PR.
5. Update `README.md` if you change the public surface.

## Releases

Tagged off `main`. Bump `Torii::Backend::VERSION` in `lib/torii/backend/version.rb` and any references in `README.md`, then:

```sh
git tag v0.0.2
git push origin v0.0.2
gem build torii-backend.gemspec
gem push torii-backend-0.0.2.gem
```

Consumers pick up the new version via `gem install torii-backend` or `bundle update torii-backend`.

## Code of Conduct

Be kind. Disagreements happen; argue the position, not the person.
