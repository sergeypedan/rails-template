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

  # "+7 (962) 123-45-23" -> "79621234523"
  #
  def unformat_phone(string_or_nil)
    string_or_nil.to_s.scan(/\d/).join
  end

  # Array, из которого будет браться информация для <select>, например:
  # [
  #   ["Российская Федерация +7", "7", { data: { country: "RU" } }]  => `<option value="7" data-country="RU">Российская Федерация +7</option>`
  # ]
  def country_select_option_data(country)
    [
      [country.translations["ru"], "+#{country.country_code}"].join(" "),
      country.country_code,
      { data: { country: country.alpha2 } }
    ]
  end

  def countries_with_phone_codes
    ISO3166::Country.all
      .sort_by { |country| country.translations["ru"] }
      .map     { |country| country_select_option_data(country) }

  end

  def countries_with_phone_codes_grouped_by_subregion
    ISO3166::Country.all
      .group_by(&:subregion)
      .map { |subregion, countries|
        [
          SUBREGIONS[subregion],
          countries.sort_by { |country| country.translations["ru"] }
                    .map    { |country| country_select_option_data(country) }

        ]
      }
  end

end


# С группировкой по регионам:
# = f.select :phone_country, grouped_options_for_select(countries_with_phone_codes_grouped_by_subregion, { selected: "7" }), { id: "countries_select" }
