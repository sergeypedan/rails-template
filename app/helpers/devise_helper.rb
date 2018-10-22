# frozen_string_literal: true

# from https://github.com/plataformatec/devise/blob/master/app/helpers/devise_helper.rb
#
module DeviseHelper

  def devise_error_messages!
    return "" if resource.errors.empty?

    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    tag.div id: "error_explanation", class: "alert alert-danger" do
      concat( tag.h4(sentence) )
      concat(
        tag.ul do
          resource.errors.full_messages.each do |msg|
            concat tag.li(msg)
          end
        end
      )
    end
  end
end
