# frozen_string_literal: true

module PhoneHelper

  # SUBREGIONS = {
  #   ""                          => "Без региона",
  #   "Australia and New Zealand" => "Австралия и Новая Зеландия",
  #   "Caribbean"                 => "Карибский бассейн",
  #   "Central America"           => "Центральная Америка",
  #   "Central Asia"              => "Средняя Азия",
  #   "Eastern Africa"            => "Восточная Африка",
  #   "Eastern Asia"              => "Восточная Азия",
  #   "Eastern Europe"            => "Восточная Европа",
  #   "Melanesia"                 => "Меланезия",
  #   "Micronesia"                => "Микронезия",
  #   "Middle Africa"             => "Центральная Африка",
  #   "Northern Africa"           => "Северная Африка",
  #   "Northern America"          => "Северная Америка",
  #   "Northern Europe"           => "Северная Европа",
  #   "Polynesia"                 => "Полинезия",
  #   "South America"             => "Южная Америка",
  #   "South-Eastern Asia"        => "Юго-восточная Азия",
  #   "Southern Africa"           => "Южная Африка",
  #   "Southern Asia"             => "Южная Азия",
  #   "Southern Europe"           => "Южная Европа",
  #   "Western Africa"            => "Западная Африка",
  #   "Western Asia"              => "Западная Азия",
  #   "Western Europe"            => "Западная Европа"
  # }

  # Uses Rails `number_to_phone` helper
  # https://apidock.com/rails/v4.2.7/ActionView/Helpers/NumberHelper/number_to_phone
  def humanize_telephone(number)
    number = unformat_phone(number)

    formatted = if number[0] == '9'
                  number_to_phone(number, { area_code: true, delimiter: ' ', raise: true })
                else
                  number_to_phone(number, { area_code: true, delimiter: '-', raise: true, pattern: /(8452)(\d{3})(\d{3})$/ })
                end

    formatted.insert(2, ' ') # Inserts a space after 2nd character
  end


  # Accepts standard HTML options like `class: 'my-class, id: 'my-id', like standard `link_to` does
  def phone_to(number, options = {}, humanize: true, icon: nil)
    return if number.blank?
    link_text = humanize ? humanize_telephone(number) : number
    link_text = fa_icon(icon, text: link_text) if icon.present?
    link_to link_text, "tel:#{unformat_phone(number)}", options.merge({ rel: :nofollow })
  end

  # Accepts standard HTML options like `class: 'my-class, id: 'my-id', like standard `link_to` does
  def phone_to(phone_number, options = {})
    link_to phone_number, "tel:#{unformat_phone(phone_number)}", options.merge({ rel: :nofollow })
  end

  # +7 (495) 123-45-67 --> +74951234567
  # 8 (495) 123-45-67  --> +74951234567
  # 7 (495) 123-45-67  --> +74951234567
  def unformat_phone(number)
    return if number.blank?
    number =  case number.first
              when '8' then number.sub(/^8/,   '') # removes leading '8'
              when '7' then number.sub(/^7/,   '') # removes leading '7'
              when '+' then number.sub('+7', '') # removes leading '+7'
              else number
              end
    number = number.gsub /\s/, ''     # removes any kind of space
    number = number.gsub /[\(\)]/, '' # removes parenthesis
    number = number.gsub /[-–—]/, ''   # removes dashes and hyphens
    return "+7#{number}"
    # phone.gsub(/[\s\(\)\-\–]/, "")
  end

  # "+7 (962) 123-45-23" -> "79621234523"
  #
  def unformat_phone(string_or_nil)
    string_or_nil.to_s.scan(/\d/).join
  end

end
