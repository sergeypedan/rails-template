# frozen_string_literal: true

module HumanizeHelper

  # Uses Rails `number_to_phone` helper
  # https://apidock.com/rails/v4.2.7/ActionView/Helpers/NumberHelper/number_to_phone
  def humanize_telephone(number)
    number = number.sub(/^8/, "") # removes leading '8'
    number = number.sub("+7", "") # removes leading '+7'

    options = {
      area_code: true,
      country_code: 7,
      delimiter: ' ',
      raise: true
    }
    number_to_phone(number, options)
  end


  def humanize_timespan(time)
    return time if time.to_i < 10 # Maybe time has literal value, like "01:00", which can convert into 1
    hours, minutes = time.to_i.divmod(60) # will return [1, 30] for 90
    "#{hours}:#{minutes}"
  end

end
