# frozen_string_literal: true

require 'json'
require 'webrick'

# In-process HTTP server that captures the body of the most recent
# PATCH/POST /api/server/v1/users/{id} call and returns a canned
# ServerUserResponse. Same WEBrick pattern as +spec/support/jwks_server.rb+;
# WEBrick's +HTTPRequest+ doesn't list PATCH in its built-in method table, so we
# extend the servlet with a +do_PATCH+ handler that does the capture. Shared by
# patch_spec and patch_wire_spec.
class PatchCaptureServer
  attr_reader :base_url
  attr_accessor :last_body, :last_auth

  RESPONSE = JSON.generate(
    id: '00000000-0000-0000-0000-000000000001',
    environmentId: '00000000-0000-0000-0000-000000000002',
    name: 'Ada Lovelace',
    firstName: 'Ada',
    lastName: 'Lovelace',
    locale: 'en',
    status: 'active',
    createdAt: '2024-01-01T00:00:00Z',
    updatedAt: '2024-01-01T00:00:00Z',
    email: 'ada@example.com',
    emailVerifiedAt: nil,
    deletedAt: nil,
    publicMetadata: {},
    privateMetadata: {},
    unsafeMetadata: {},
  ).freeze

  class CaptureServlet < WEBrick::HTTPServlet::AbstractServlet
    def initialize(server, harness)
      super(server)
      @harness = harness
    end

    def do_PATCH(req, res)
      @harness.last_body = req.body
      @harness.last_auth = req['authorization']
      res.status = 200
      res['content-type'] = 'application/json'
      res.body = RESPONSE
    end

    def do_POST(req, res)
      @harness.last_body = req.body
      @harness.last_auth = req['authorization']
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
