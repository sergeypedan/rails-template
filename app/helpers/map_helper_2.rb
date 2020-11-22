# frozen_string_literal: true

module MapHelper

  OFFSET_DISTANCE = 0.00015
  LOCATION_EQUALITY_TRHESHOLD = 0.00005
  PROPORTION_NORMALIZATION = 1.8        # подбирается вручную для Москвы


  # @index starts from 1
  def calculate_marker_angle(markers_count, marker_index)
    segment_angle = 360 / markers_count
    return 0 + (segment_angle * marker_index)
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

  def quests_in_this_location(quests, coordinates)
    quests.select { |quest| quest.latitude.present? && quest.longitude.present? && coordinates[:latitude] == quest.latitude && coordinates[:longitude] == quest.longitude }
  end

  def maps_provider
    (@country&.url == 'ua') ? 'Google' : 'Yandex'
  end

	def embed_streetview(code:, width: 800, height: 450)
		src = "https://www.google.com/maps/embed?#{code}"
		content_tag :iframe, nil, src: src, width: width, height: height, frameborder: 0, allowfullscreen: "", style: "border: 0"
	end


	def embed_gmap(code:, width: 800, height: 450)
		src = "https://www.google.com/maps/embed?#{code}"
		content_tag :iframe, nil, src: src, width: width, height: height, frameborder: 0, allowfullscreen: "", style: "border: 0"
	end

end
