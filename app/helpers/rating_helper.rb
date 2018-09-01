require "rating_fa_stars_generator"

module RatingHelper

  def rating_stars_html(mark)
    RatingFaStarsGenerator.new(mark).call
  end

end
