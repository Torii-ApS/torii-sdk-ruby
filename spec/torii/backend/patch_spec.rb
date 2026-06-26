# frozen_string_literal: true

require 'json'

require_relative '../../support/patch_capture_server'

# Cover the Torii::Backend::Patch wrapper and verify that users.update
# assembles a correct PATCH body — Patch.set(value) emits the value
# (with nil → JSON null for clear); omitted kwargs are absent from the
# body entirely.
RSpec.describe Torii::Backend::Patch do
  describe '.set' do
    it 'wraps a value' do
      p = described_class.set('Ada')
      expect(p.value).to eq('Ada')
    end

    it 'accepts an explicit nil (this is how callers clear a field)' do
      p = described_class.set(nil)
      expect(p.value).to be_nil
    end
  end
end

RSpec.describe Torii::Backend::Client, '#users.update body assembly' do
  let(:server) { PatchCaptureServer.new }
  let(:client) { Torii::Backend::Client.new(secret_key: 'sk_test_x', api_url: server.base_url) }
  let(:user_id) { '00000000-0000-0000-0000-000000000001' }

  after { server.stop }

  it 'omits unset kwargs from the body entirely' do
    client.users.update(user_id, first_name: Torii::Backend::Patch.set('Ada'))
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq('firstName' => 'Ada')
  end

  it 'emits JSON null for Patch.set(nil)' do
    client.users.update(user_id, last_name: Torii::Backend::Patch.set(nil))
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq('lastName' => nil)
    # Sanity check the literal wire format includes "null", not just
    # that JSON.parse round-trips to a Ruby nil.
    expect(server.last_body).to include('"lastName":null')
  end

  it 'mixes set value + set nil + omitted in one call' do
    client.users.update(
      user_id,
      first_name: Torii::Backend::Patch.set('Ada'),
      last_name: Torii::Backend::Patch.set(nil),
      # locale, unsafe_metadata omitted
    )
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq('firstName' => 'Ada', 'lastName' => nil)
  end

  it 'translates snake_case kwargs to camelCase JSON keys and keeps a bag as an object' do
    client.users.update(
      user_id,
      unsafe_metadata: Torii::Backend::Patch.set({ 'tier' => 'pro' }),
    )
    parsed = JSON.parse(server.last_body)
    expect(parsed).to eq(
      'unsafeMetadata' => { 'tier' => 'pro' },
    )
  end

  it 'sends an empty JSON object when no kwargs are passed' do
    client.users.update(user_id)
    expect(server.last_body).to eq('{}')
  end

  it 'raises if a kwarg is not a Patch' do
    expect { client.users.update(user_id, first_name: 'Ada') }
      .to raise_error(ArgumentError, /must be a Torii::Backend::Patch/)
  end

  it 'raises on an unknown field name' do
    expect { client.users.update(user_id, nope: Torii::Backend::Patch.set('x')) }
      .to raise_error(ArgumentError, /unknown PATCH field/)
  end

  it 'sends the bearer token on the hand-rolled PATCH path' do
    client.users.update(user_id, first_name: Torii::Backend::Patch.set('Ada'))
    # Auth rides the generated bearerAuth scheme + config access token, even
    # though the body is hand-built via debug_body.
    expect(server.last_auth).to eq('Bearer sk_test_x')
  end

  it 'creates via the generated client: omits unset metadata, sends bearer' do
    client.users.create(email: 'ada@example.com')
    expect(JSON.parse(server.last_body)).to eq('email' => 'ada@example.com')
    expect(server.last_auth).to eq('Bearer sk_test_x')
  end
end
