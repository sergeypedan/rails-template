# frozen_string_literal: true

if Rails.env.development?
  Rails.application.config.after_initialize do
    Bullet.add_footer   = true
    Bullet.console      = false
    Bullet.enable       = true
    Bullet.rails_logger = false
  end
end
