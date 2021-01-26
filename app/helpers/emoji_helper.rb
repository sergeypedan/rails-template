# frozen_string_literal: true

module EmojiHelper

  DINGABATS_REGEX = /[\u{2702}-\u{27b0}]/

  require "unicode/emoji" # from gem "unicode-emoji"
  #
  # Not replacing multiple spaces with 1 space as this function may be applied to JSONs
  # If we needed only alphanumerical, could use .gsub(/[^[:alnum:][:blank:][:punct:]]/, '')
  #
  def strip_emoji(input)
    return input unless input.is_a? String # we can replace emoji only in strings, so ignoring anything else
    return '' if input == '' # faster than .blank?
    str = input.scrub(' ') # replaces invalid byte sequences with ' '
    str = str.force_encoding('utf-8').encode # this dictates `frozen_string_literal: false`
    str = str.gsub Unicode::Emoji::REGEX_WELL_FORMED_INCLUDE_TEXT, ''
    str = str.gsub DINGABATS_REGEX, ''
    str
  end

  # Mass strips emoji from several columns of a record. Use like so:
  #
  #  include EmojiHelper
  #  mass_strip_emoji!(@order, [:client_comment, :comment_owner])
  #
  def mass_strip_emoji!(record, columns)
    fail ArgumentError, ":record must be an ActiveRecord::Base, you pass a #{record.class}" unless record.is_a? ActiveRecord::Base
    fail ArgumentError, ":columns must be an Array, you pass #{columns.class}" unless columns.is_a? Array
    fail ArgumentError, ":columns must include only symbols" if columns.grep(Symbol).size != columns.size
    columns.each do |column|
      record.public_send "#{column}=", strip_emoji(record.public_send(column))
    end
    return record
  end


  REGEX_DINGBATS              = /[\u{2702}-\u{27b0}]/
  REGEX_EMOTICONS             = /[\u{1f600}-\u{1f64f}]/
  REGEX_ENCLOSED_CHARS        = /[\u{24C2}-\u{1F251}]/
  REGEX_SYMBOLS_PICS          = /[\u{1f300}-\u{1f5ff}]/
  REGEX_TRANSPORT_SMBLS       = /[\u{1f680}-\u{1f6ff}]/
  # REGEX_ORNAMENTAL_DINGBATS = /[\u{1f650}-\u{1f67f}]/
  # REGEX_?                   = /[\u{1f1e6}-\u{1f1ff}]/
  # REGEX_?                   = /[\u{2700}-\u{27bf}]/
  # REGEX_?                   = /[\u{1f900}-\u{1f9ff}]/
  # REGEX_?                   = /[\u{2600}-\u{26ff}]/
  #
  def strip_emoji_manual(str)
    return str if str.nil?
    return str if str == ""
    fail ArgumentError, "Accepts only String and nil, you pass a #{str.class}" unless [String, NilClass].include? str.class

    str = str.force_encoding('utf-8').encode

    result =    str.gsub REGEX_EMOTICONS, ''
    result = result.gsub REGEX_DINGBATS, ''
    result = result.gsub REGEX_TRANSPORT_SMBLS, ''
    result = result.gsub REGEX_ENCLOSED_CHARS, ''
    result = result.gsub REGEX_SYMBOLS_PICS, ''
  end

end
