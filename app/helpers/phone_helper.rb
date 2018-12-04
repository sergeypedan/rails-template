# frozen_string_literal: true

module PhoneHelper

  # Uses Rails `number_to_phone` helper
  # https://apidock.com/rails/v4.2.7/ActionView/Helpers/NumberHelper/number_to_phone
  def humanize_telephone(number)
    number = unformat_phone(number)
    number_to_phone(number, { area_code: true, country_code: 7, delimiter: ' ', raise: true })
  end


  def phone_to(number, options = {})
    return if number.blank?
    link_to humanize_telephone(number), "tel:+7#{unformat_phone(number)}", options
  end


  # +7 (495) 123-45-67 --> 4951234567
  # 8 (495) 123-45-67  --> 4951234567
  # 7 (495) 123-45-67  --> 4951234567
  def unformat_phone(number)
    number =  case number.first
              when '8' then number.sub(/^8/,   '') # removes leading '8'
              when '7' then number.sub(/^7/,   '') # removes leading '7'
              when '+' then number.sub('+7', '') # removes leading '+7'
              else number
              end
    number = number.gsub /\s/, ''     # removes any kind of space
    number = number.gsub /[\(\)]/, '' # removes parenthesis
    number = number.gsub /[-–—]/, ''   # removes dashes and hyphens
  end


  # https://vk.com --> vk.com
  # http://vk.com  --> vk.com
  def un_http(url)
    url.sub(/(http|https):\/\//, '')
  end

end
