# frozen_string_literal: true

require 'faraday'

require_relative './middleware/git_hub_release_body_binaries_parser'

class GitHubClient
  def initialize(github_owner, github_repo, opts = {})
    @uri = URI("https://api.github.com/repos/#{github_owner}/#{github_repo}")
    @headers = {
      'User-Agent' => 'gradybarrett',
      'Accept' => 'application/vnd.github.v3+json'
    }
    @connection = opts.fetch('connection') { build_connection }
  end

  def get_release(tag)
    @connection.get "releases/tags/#{tag}"
  end

  private

  def build_connection
    Faraday.new(url: @uri, headers: @headers) do |faraday|
      faraday.use GitHubReleaseBodyBinariesParser
      faraday.adapter Faraday.default_adapter
    end
  end
end
