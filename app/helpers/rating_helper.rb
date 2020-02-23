# frozen_string_literal: true

require "rating_fa_stars_generator"

module RatingHelper

  def rating_stars_html(mark)
    RatingFaStarsGenerator.new(mark).call
  end

  # Converts 0…100 scale into 1…5 scale (because we store `item.sort_rating` in 0…100 format)
  def mark_100_to_5(mark)
    rescale_mark(mark: mark, source_scale: 0..100, target_scale: 1..5)
  end

  def mark_5_to_100(mark)
    rescale_mark(mark: mark, source_scale: 1..5, target_scale: 0..100)
  end

  def rescale_mark(mark: nil, source_scale:, target_scale:)
    return unless mark
    fail ArgumentError, "`mark` must be a Numeric, you passed '#{mark}' (#{mark.class})" unless mark.is_a? Numeric
    fail ArgumentError, "`source_scale` must be a Range, you passed '#{source_scale}' (#{source_scale.class})" unless source_scale.is_a? Range
    fail ArgumentError, "`target_scale` must be a Range, you passed '#{target_scale}' (#{target_scale.class})" unless target_scale.is_a? Range
    fail ArgumentError, "`mark` (#{mark}) must be within `source_scale` (#{source_scale})" unless source_scale.cover? mark

    source_scale_size = (source_scale.max - source_scale.min).to_f
    target_scale_size = (target_scale.max - target_scale.min).to_f
    resize_factor     = target_scale_size / source_scale_size
    mark_size         = (mark - source_scale.min).to_f
    rescaled_mark     = mark_size * resize_factor
    return rescaled_mark + target_scale.min
  end

end
