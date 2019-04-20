# frozen_string_literal: true

class VersionSet
  attr_reader :tags, :failed_tags

  def initialize
    @tags = []
    @version_set = {}
    @failed_tags = []
  end

  def [](k)
    @version_set[k]
  end

  def store(k, v)
    @version_set[k] = Set.new unless @version_set.key?(k)
    @version_set[k] << v
  end

  def to_s
    str_array = ["Tag(s) searched successfully: #{@tags.join(', ')}\n"]
    str_array << "Tag search failures: #{@failed_tags.join(', ')}\n" unless @failed_tags.empty?

    str_array << "\nBinary Set Unions:\n"
    @version_set.each do |binary, versions|
      str_array << "#{binary}: #{versions.to_a.sort.join(', ')}\n"
    end

    str_array.join('')
  end
end
