# frozen_string_literal: true

require 'json'
require 'webrick'

# Cover the Torii::Backend::Patch wrapper and verify that users.update
# assembles a correct PATCH body — Patch.set(value) emits the value,
# Patch.clear emits a JSON null, omitted kwargs are absent from the body.
RSpec.describe Torii::Backend::Patch do
  describe '.set' do
    it 'wraps a value in the :set state' do
      p = described_class.set('Ada')
      expect(p.set?).to be(true)
      expect(p.clear?).to be(false)
      expect(p.value).to eq('Ada')
    end

    it 'accepts an explicit nil value (still a :set, not a :clear)' do
      # Edge case: someone could pass +Patch.set(nil)+. We treat that as
      # "set to nil" — semantically equivalent to clear but still flagged
      # set so the body assembly emits null. This keeps the constructor
      # honest about state vs. value.
      p = described_class.set(nil)
      expect(p.set?).to be(true)
      expect(p.value).to be_nil
    end
  end

  describe '.clear' do
    it 'returns a frozen singleton in the :clear state' do
      expect(described_class.clear.clear?).to be(true)
      expect(described_class.clear.set?).to be(false)
      expect(described_class.clear).to be(described_class.clear)
      expect(described_class.clear).to be_frozen
    end
  end

  describe '#initialize' do
    it 'rejects an unknown state' do
      expect { described_class.new(:unknown) }.to raise_error(ArgumentError, /:set or :clear/)
    end
  end
end

# In-process HTTP server that captures the body of the most recent
# PATCH /api/server/v1/users/{id} call and returns a canned UserResponse.
# Same WEBrick pattern as +spec/support/jwks_server.rb+; WEBrick's
# +HTTPRequest+ doesn't list PATCH in its built-in method table, so we
# extend the servlet with a +do_PATCH+ handler that does the capture.
class PatchCaptureServer
  attr_reader :base_url
  attr_accessor :last_body

  RESPONSE = JSON.generate(
    id: '00000000-0000-0000-0000-000000000001',
    environmentId: '00000000-0000-0000-0000-000000000002',
    status: 'active',
    createdAt: '2024-01-01T00:00:00Z',
    updatedAt: '2024-01-01T00:00:00Z',
  ).freeze

  class CaptureServlet < WEBrick::HTTPServlet::AbstractServlet
    def initialize(server, harness)
      super(server)
      @harness = harness
    end

    def do_PATCH(req, res)
      @harness.last_body = req.body
      res.status = 200
      res['content-type'] = 'application/json'
      res.body = RESPONSE
    end
  end

  def initialize
    @server = WEBrick::HTTPServer.new(
      Port: 0,
      Logger: WEBrick::Log.new(File::NULL),
      AccessLog: [],
      BindAddress: '127.0.0.1',
    )
    @server.mount('/', CaptureServlet, self)
    @thread = Thread.new { @server.start }
    @base_url = "http://127.0.0.1:#{@server.config[:Port]}"
  end

  def stop
    @server.shutdown
    @thread.join(2)
  end
end

RSpec.describe Torii::Backend::Client, '#users.update body assembly' do
  let(:server) { PatchCaptureServer.new }
  let(:client) { Torii::Backend::Client.new(secret_key: 'sk_test_x', api_url: server.base_url) }
  let(:user_id) { '00000000-0000-0000-0000-000000000001' }

  after { server.stop }

  it 'omits unset kwargs from the body entirely' do
    client.users.update(user_id, name: Torii::Backend::Patch.set('Ada'))
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq('name' => 'Ada')
  end

  it 'emits JSON null for Patch.clear' do
    client.users.update(user_id, phone: Torii::Backend::Patch.clear)
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq('phone' => nil)
    # Sanity check the literal wire format includes "null", not just
    # that JSON.parse round-trips to a Ruby nil.
    expect(server.last_body).to include('"phone":null')
  end

  it 'mixes set + clear + omitted in one call' do
    client.users.update(
      user_id,
      name: Torii::Backend::Patch.set('Ada'),
      phone: Torii::Backend::Patch.clear,
      # locale, address, avatar_url, date_of_birth all omitted
    )
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq('name' => 'Ada', 'phone' => nil)
  end

  it 'translates snake_case kwargs to camelCase JSON keys' do
    client.users.update(
      user_id,
      avatar_url: Torii::Backend::Patch.set('https://example.com/a.png'),
      date_of_birth: Torii::Backend::Patch.clear,
    )
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq(
      'avatarUrl' => 'https://example.com/a.png',
      'dateOfBirth' => nil,
    )
  end

  it 'sends an empty JSON object when no kwargs are passed' do
    client.users.update(user_id)
    expect(server.last_body).to eq('{}')
  end

  it 'raises if a kwarg is not a Patch' do
    expect { client.users.update(user_id, name: 'Ada') }
      .to raise_error(ArgumentError, /must be a Torii::Backend::Patch/)
  end

  it 'raises on an unknown field name' do
    expect { client.users.update(user_id, nope: Torii::Backend::Patch.set('x')) }
      .to raise_error(ArgumentError, /unknown PATCH field/)
  end
end
