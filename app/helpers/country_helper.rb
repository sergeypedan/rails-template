# frozen_string_literal: true

module CountryHelper

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
