# frozen_string_literal: true

require 'json'

class GitHubReleaseBodyBinariesParser
  def initialize(app)
    @binaries_container_key = default_binaries_container_key
    @app = app
  end

  def call(request_env)
    @app.call(request_env).on_complete do |response_env|
      response_env.body = parse_body(response_env.body) if response_env.success?

      response_env
    end
  end

  private

  def default_binaries_container_key
    'body'
  end

  def parse_body(body)
    version_regex = Regexp.new(/(j?ruby|bundler)\s\|\s([\d+\.]+\d)\s/)

    body = JSON.parse(body)

    body['body'].scan(version_regex)
  end
end
