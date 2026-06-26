# frozen_string_literal: true

require_relative '../../support/jwks_server'

# Spin up an in-process JWKS server, mint ES256 JWTs against a generated
# keypair, and cover the success path plus every documented failure mode.
# No external network.
RSpec.describe Torii::Backend, 'verify_token' do
  let(:server) { JwksServer.new }
  let(:issuer) { server.issuer }

  before { Torii::Backend.clear_jwks_cache_for_tests }
  after  { server.stop }

  def base_claims(overrides = {})
    now = Time.now.to_i
    {
      'sub' => 'user_123',
      'pid' => 'env_abc',
      'iss' => issuer,
      'iat' => now,
      'exp' => now + 300,
    }.merge(overrides)
  end

  it 'verifies a well-formed JWT and extracts claims' do
    token = server.sign(base_claims(
      'email_verified' => true,
      'profile_complete' => true,
      'locale' => 'en',
    ))
    auth = Torii::Backend.verify_token(token, issuer: issuer)
    expect(auth.user_id).to eq('user_123')
    expect(auth.environment_id).to eq('env_abc')
    expect(auth.issuer).to eq(issuer)
    expect(auth.email_verified).to be(true)
    expect(auth.profile_complete).to be(true)
    expect(auth.impersonating).to be(false)
    expect(auth.locale).to eq('en')
    expect(auth.raw).to include('sub' => 'user_123')
  end

  it 'defaults profile_complete to true when claim is absent' do
    token = server.sign(base_claims)
    auth = Torii::Backend.verify_token(token, issuer: issuer)
    expect(auth.profile_complete).to be(true)
  end

  it 'rejects a JWT signed by a different key' do
    other = OpenSSL::PKey::EC.generate('prime256v1')
    token = server.sign(base_claims, key_override: other)
    expect { Torii::Backend.verify_token(token, issuer: issuer) }.to raise_error(Torii::Backend::AuthError)
  end

  it 'rejects a JWT with the wrong issuer' do
    token = server.sign(base_claims('iss' => 'http://wrong-issuer.example'))
    expect { Torii::Backend.verify_token(token, issuer: issuer) }.to raise_error(Torii::Backend::AuthError)
  end

  it 'rejects a JWT missing a required claim (sub)' do
    claims = base_claims
    claims.delete('sub')
    token = server.sign(claims)
    expect { Torii::Backend.verify_token(token, issuer: issuer) }.to raise_error(Torii::Backend::AuthError)
  end

  it 'rejects a JWT missing the pid claim' do
    claims = base_claims
    claims.delete('pid')
    token = server.sign(claims)
    expect { Torii::Backend.verify_token(token, issuer: issuer) }.to raise_error(Torii::Backend::AuthError)
  end

  it 'rejects an expired JWT' do
    now = Time.now.to_i
    token = server.sign(base_claims('iat' => now - 600, 'exp' => now - 60))
    expect { Torii::Backend.verify_token(token, issuer: issuer) }.to raise_error(Torii::Backend::AuthError)
  end
end

RSpec.describe Torii::Backend, 'authenticate_request' do
  let(:server) { JwksServer.new }
  let(:issuer) { server.issuer }

  before { Torii::Backend.clear_jwks_cache_for_tests }
  after  { server.stop }

  def valid_token
    now = Time.now.to_i
    server.sign({
      'sub' => 'u', 'pid' => 'e', 'iss' => issuer, 'iat' => now, 'exp' => now + 300,
    })
  end

  it 'verifies a bearer token from a Rack-style env hash' do
    env = { 'HTTP_AUTHORIZATION' => "Bearer #{valid_token}" }
    auth = Torii::Backend.authenticate_request(env, issuer: issuer, header: 'HTTP_AUTHORIZATION')
    expect(auth.user_id).to eq('u')
  end

  it 'verifies a bearer token from a plain headers hash (lowercase key)' do
    headers = { 'authorization' => "Bearer #{valid_token}" }
    auth = Torii::Backend.authenticate_request(headers, issuer: issuer)
    expect(auth.user_id).to eq('u')
  end

  it 'verifies a bearer token from a plain headers hash (symbol key)' do
    headers = { authorization: "Bearer #{valid_token}" }
    auth = Torii::Backend.authenticate_request(headers, issuer: issuer)
    expect(auth.user_id).to eq('u')
  end

  it 'raises when the authorization header is missing' do
    expect { Torii::Backend.authenticate_request({}, issuer: issuer) }
      .to raise_error(Torii::Backend::AuthError, /Missing/)
  end

  it 'raises when the authorization header is not in Bearer form' do
    env = { 'HTTP_AUTHORIZATION' => 'Basic abc==' }
    expect { Torii::Backend.authenticate_request(env, issuer: issuer, header: 'HTTP_AUTHORIZATION') }
      .to raise_error(Torii::Backend::AuthError, /Bearer/)
  end
end

RSpec.describe Torii::Backend, 'verify_webhook (stub)' do
  it 'raises AuthError indicating the subsystem is not yet available' do
    expect do
      Torii::Backend.verify_webhook(secret: 's', headers: {}, payload: 'p')
    end.to raise_error(Torii::Backend::AuthError, /not yet available/)
  end
end
