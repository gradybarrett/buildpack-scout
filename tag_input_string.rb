# frozen_string_literal: true

class TagInputString < String
  def initialize(str)
    super(trim_superfluous_characters(str))
  end

  private

  def trim_superfluous_characters(str)
    str.gsub(/^(\s|,)+|\s|(\s|,)+$/, '')
  end
end
