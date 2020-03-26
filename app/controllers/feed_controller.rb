# frozen_string_literal: true

class FeedController < ApplicationController

  def index
    respond_to do |format|
      format.xml { render layout: false }
      format.rss { render layout: false }
    end
  end

end
