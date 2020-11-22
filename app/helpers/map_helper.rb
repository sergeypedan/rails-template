# frozen_string_literal: true

module MapHelper

  OFFSET_DISTANCE = 0.00015
  PROPORTION_NORMALIZATION = 1.8 # подбирается вручную для Москвы


  # @index starts from 1
  def calculate_marker_angle(markers_count, marker_index)
    segment_angle = 360 / markers_count
    return 0 + (segment_angle * marker_index)
  end


  def items_in_this_location(items, coordinates)
    items.select do |item|
      (coordinates[:latitude] == item.latitude) && (coordinates[:longitude] == item.longitude)
    end
  end


  def maps_provider
    (@country&.name == 'Украина') ? 'Google' : 'Yandex'
  end


  def noized_coordinate(coordinate)
    coordinate.to_f + 0.000003 * ( 50 - rand(100) )
  end


  def offset_coordinates(markers_count, marker_index, latitude, longitude)
    angle = calculate_marker_angle(markers_count, marker_index)

    {
      latitude:  (latitude.to_f +  OFFSET_DISTANCE * Math.sin(Math::PI * (angle + 90) / 180)),
      longitude: (longitude.to_f + OFFSET_DISTANCE * Math.cos(Math::PI * (angle + 90) / 180) * PROPORTION_NORMALIZATION)
    }
  end

  # Used in shared partial with `@main_items` & other links to map
  # @returns `nil` as fallback, and links rely on that
  def corresponding_map_page_path
    case controller_name
    when 'categories' then category_map_path(current_city_url: @current_city.url, url: @category.url)
    #when 'cities'     then city_map_path(current_city_url: @current_city.url)
    #when 'domains'    then city_map_path(current_city_url: @current_city.url)
    when 'lists'      then map_list_path(url: @list.url)
    when 'metros'     then metro_map_path(current_city_url: @current_city.url, url: @metro.url) # here another 2 types of metro
    when 'tags'       then tag_map_path(current_city_url: @current_city.url, url: @tag.url)
    end
  end

end
