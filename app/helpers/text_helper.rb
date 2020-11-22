# frozen_string_literal: true

module TextHelper

  # Opposite to String.capitalize
  # 'Welcome to Miami' -> 'welcome to Miami'
  #
  def uncapitalize(string)
    return if string.blank?
    str = string.to_s
    str[0, 1].downcase + str[1..-1]
  end

  # first substitutes left quote, than right quote
  def to_inner_quotes(string)
    string.sub(/«|\"|\'/, "„")
          .sub(/»|\"|\'|”/, "“")
  end

end
