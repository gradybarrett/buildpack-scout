# frozen_string_literal: true

require 'bundler/setup'

require_relative './tag_input_string'
require_relative './clients/github/github_client'
require_relative './version_set'

puts 'Enter comma separated version tags:'
input = STDIN.gets
tags_input = TagInputString.new(input)
puts

version_tags = tags_input.split(',')

versions = version_tags.each_with_object(VersionSet.new) do |tag, set|
  client = GitHubClient.new('cloudfoundry', 'ruby-buildpack')

  response = client.get_release(tag)
  if response.success?
    set.tags << tag

    response.body.each do |binary, version|
      set.store(binary, version)
    end
  else
    set.failed_tags << tag
  end
end

puts(versions.to_s)
