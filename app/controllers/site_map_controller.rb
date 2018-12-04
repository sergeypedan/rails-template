# frozen_string_literal: true

class SiteMapController < ApplicationController

  def index
    @articles      = Article.published
    @astrologers   = Astrologer.published
    @concepts      = Concept.published
    @consultations = Consultation.published
    @courses       = ::Course.published
    @kootas        = Koota.all
    # @nakshatras    = ::Nakshatra.all
    @planets       = ::Planet.all
    # @planet_house  = PlanetHouse.all
    # @planet_sign   = PlanetSign.all
    @products      = Product.published
    # @questions     = Question.published
    @tithis        = ::Tithi.all
    @zodiac_signs  = ZodiacSign.all

    respond_to do |format|
      format.xml { render layout: false }
    end
  end

end
