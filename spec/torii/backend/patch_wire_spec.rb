# frozen_string_literal: true

require 'json'

require_relative '../../support/patch_capture_server'

# Wire-parity against the shared contract fixtures
# (contract-tests/fixtures/patch-wire). For each UpdateUserRequest fixture we
# build Patch-keyed kwargs from expectedBody and assert the SDK PATCHes exactly
# those bytes — the same fixtures the server round-trip test asserts. Covers the
# tri-state path (set / clear / omit) and the metadata key-delete case.
RSpec.describe Torii::Backend::Client, 'patch-wire parity' do
  let(:server) { PatchCaptureServer.new }
  let(:client) { Torii::Backend::Client.new(secret_key: 'sk_test_x', api_url: server.base_url) }
  let(:user_id) { '00000000-0000-0000-0000-000000000001' }

  after { server.stop }

  def self.camel_to_snake(key)
    key.gsub(/([A-Z])/) { "_#{Regexp.last_match(1).downcase}" }
  end

  fixtures_path = File.expand_path('../../support/patch_wire_fixtures.json', __dir__)
  manifest = JSON.parse(File.read(fixtures_path))
  manifest['fixtures']
    .select { |fixture| fixture['schema'] == 'UpdateUserRequest' }
    .each do |fixture|
      it "emits the blessed wire bytes for #{fixture['name']}" do
        expected = fixture['expectedBody']
        # Build the kwargs generically from expectedBody: a present key (incl. one
        # mapped to null) becomes Patch.set(value); an absent key is never added,
        # so it is omitted from the wire body.
        patches = expected.each_with_object({}) do |(json_key, value), acc|
          acc[self.class.camel_to_snake(json_key).to_sym] = Torii::Backend::Patch.set(value)
        end

        client.users.update(user_id, **patches)

        expect(JSON.parse(server.last_body)).to eq(expected)
      end
    end
end
