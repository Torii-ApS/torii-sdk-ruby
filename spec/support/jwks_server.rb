# frozen_string_literal: true

require 'base64'
require 'json'
require 'openssl'
require 'webrick'

# Tiny in-process JWKS server. Generates a fresh ES256 keypair on
# construction, exposes the public half at
# +/_torii/.well-known/jwks.json+, and tears itself down on +stop+. Used
# by the verify_token / authenticate_request specs to exercise the
# happy path and every documented failure mode without touching the
# network.
class JwksServer
  attr_reader :private_key, :public_key, :kid, :issuer

  def initialize(kid: 'test-key-1')
    @kid = kid
    @private_key = OpenSSL::PKey::EC.generate('prime256v1')
    # OpenSSL 3 made pkeys immutable, so we round-trip the public half
    # through PEM rather than mutating a copy.
    @public_key = OpenSSL::PKey::EC.new(@private_key.public_to_pem)
    @jwks_body = JSON.generate(keys: [jwk])
    @server = WEBrick::HTTPServer.new(
      Port: 0,
      Logger: WEBrick::Log.new(File::NULL),
      AccessLog: [],
      BindAddress: '127.0.0.1',
    )
    @server.mount_proc('/_torii/.well-known/jwks.json') do |_req, res|
      res.status = 200
      res['content-type'] = 'application/json'
      res.body = @jwks_body
    end
    @thread = Thread.new { @server.start }
    @issuer = "http://127.0.0.1:#{@server.config[:Port]}"
  end

  def stop
    @server.shutdown
    @thread.join(2)
  end

  # JWT-encode a payload with this server's private key, producing a
  # token whose +kid+ header matches what the JWKS advertises.
  def sign(claims, kid_override: nil, key_override: nil)
    JWT.encode(
      claims,
      key_override || @private_key,
      'ES256',
      { 'kid' => kid_override || @kid },
    )
  end

  private

  def jwk
    # The +jwt+ gem can export an EC key as a JWK — easier than rolling
    # the BIG-endian base64url coordinate dance by hand.
    JWT::JWK.new(@public_key, { kid: @kid, use: 'sig', alg: 'ES256' }).export
  end
end
