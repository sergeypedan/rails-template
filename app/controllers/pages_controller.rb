# frozen_string_literal: true

class PagesController < ApplicationController

  def contacts
    @content = Content.find_by(uid: "contacts", published: true)
    render :text_page
  end

  def privacy_policy
    @content = Content.find_by(uid: "privacy", published: true)
    render :text_page
  end

  def terms
    @content = Content.find_by(uid: "terms", published: true)
    render :text_page
  end

  def oferta
    @content = Content.find_by(uid: "oferta", published: true)
    render :text_page
  end

end
