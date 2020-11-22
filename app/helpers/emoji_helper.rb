# frozen_string_literal: true

module EmojiHelper

  require "unicode/emoji"
  # gem "unicode-emoji"

  DINGABATS_REGEX = /[\u{2702}-\u{27b0}]/

  def strip_emoji(input)
    string = input.to_s.scrub(' ') # replaces invalid byte sequences with ' '
    return "" if string == "" # faster than .blank?
    string = string.force_encoding('utf-8').encode
    string = string.gsub Unicode::Emoji::REGEX_WELL_FORMED_INCLUDE_TEXT, ''
    string = string.gsub DINGABATS_REGEX, ''
    string
  end

end
