# frozen_string_literal: true

lib = File.expand_path('src', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torii/backend/version'

Gem::Specification.new do |spec|
  spec.name        = 'torii-backend'
  spec.version     = Torii::Backend::VERSION
  spec.authors     = ['torii']
  spec.email       = ['hello@torii.so']
  spec.summary     = 'Backend SDK for torii — verify JWTs and call the server API.'
  spec.description = <<~DESC
    Backend SDK for torii. Verify end-user JWTs without a per-request
    round-trip, call /api/server/v1/** with a secret key, and react to
    events from torii. Ships with Rack middleware that works with Rails,
    Sinatra, Roda, and anything else Rack-compatible.
  DESC
  spec.homepage = 'https://github.com/Torii-ApS/torii-sdk-ruby'
  spec.license  = 'MIT'

  spec.required_ruby_version = '>= 3.1'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true',
  }

  spec.files = Dir[
    'src/**/*.rb',
    'spec/server-v1.json',
    'README.md',
  ]
  spec.require_paths = ['src']

  # Runtime
  # +typhoeus+ is what openapi-generator's Ruby template uses under the
  # hood; it's a libcurl-backed HTTP client. We pin it loosely so apps
  # can use a newer minor without forcing a gem update here.
  spec.add_dependency 'jwt', '~> 2.8'
  spec.add_dependency 'typhoeus', '~> 1.4'

  # Development
  spec.add_development_dependency 'rack', '~> 3.1'
  spec.add_development_dependency 'rspec', '~> 3.13'
  # WEBrick was removed from Ruby's stdlib as of 3.0 — needed only for
  # the in-process JWKS server in the test suite.
  spec.add_development_dependency 'webrick', '~> 1.8'
end
