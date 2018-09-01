# frozen_string_literal: true

# Генератор звёздочек рейтинга через иконки FontAwesome v.4
# Нужен подключённый gem 'font-awesome-rails', '~> 4.7'

class RatingFaStarsGenerator < ActionView::Base

  include FontAwesome::Rails::IconHelper

  def initialize(mark)
    @mark = mark
  end

  def call
    return if @mark.blank?
    fail ArgumentError, "rating mark must be a Numeric, received #{@mark.inspect}" unless @mark.is_a? Numeric
    return if @mark.zero?

    difference  = (@mark - @mark.floor)
    half_stars  = (0.25..0.75).include?(difference) ? 1 : 0
    full_stars  = (difference > 0.75) ? @mark.ceil : @mark.floor
    empty_stars = (5 - full_stars - half_stars)

    tag.span class: 'rating-stars', data: { rating: @mark } do
       full_stars.times { concat( fa_icon('star') ) }
       half_stars.times { concat( fa_icon('star-half-o') ) }
      empty_stars.times { concat( fa_icon('star-o') ) }
    end
  end

end
