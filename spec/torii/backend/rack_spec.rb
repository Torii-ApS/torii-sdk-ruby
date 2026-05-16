# frozen_string_literal: true

require 'json'

require_relative '../../support/jwks_server'

RSpec.describe Torii::Backend::Rack::RequireAuth do
  let(:server) { JwksServer.new }
  let(:issuer) { server.issuer }
  let(:inner) { ->(env) { [200, { 'content-type' => 'text/plain' }, ["hi #{env['torii.auth'].user_id}"]] } }
  let(:middleware) { described_class.new(inner, issuer: issuer) }

  before { Torii::Backend.clear_jwks_cache_for_tests }
  after  { server.stop }

  def valid_token
    now = Time.now.to_i
    server.sign({ 'sub' => 'user_xyz', 'pid' => 'env_abc', 'iss' => issuer, 'iat' => now, 'exp' => now + 300 })
  end

  it 'forwards to the app and exposes torii.auth in env on success' do
    env = { 'HTTP_AUTHORIZATION' => "Bearer #{valid_token}" }
    status, _headers, body = middleware.call(env)
    expect(status).to eq(200)
    expect(body.first).to eq('hi user_xyz')
    expect(env['torii.auth']).to be_a(Torii::Backend::Auth)
    expect(env['torii.auth'].user_id).to eq('user_xyz')
  end

  it 'returns 401 with a JSON error body when the header is missing' do
    status, headers, body = middleware.call({})
    expect(status).to eq(401)
    expect(headers['content-type']).to eq('application/json')
    parsed = JSON.parse(body.first)
    expect(parsed.dig('error', 'code')).to eq('authentication_failed')
    expect(parsed.dig('error', 'message')).to match(/Missing/)
  end

  it 'returns 401 when the token is malformed' do
    env = { 'HTTP_AUTHORIZATION' => 'Bearer not-a-jwt' }
    status, _headers, body = middleware.call(env)
    expect(status).to eq(401)
    expect(JSON.parse(body.first).dig('error', 'code')).to eq('authentication_failed')
  end
end
