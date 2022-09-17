ActiveAdmin.setup do |config|
  config.batch_actions = true
  config.breadcrumb = true
  config.comments = false
  config.create_another = true
  config.default_per_page = 200
  config.display_name_methods = [:active_admin_name, :display_name, :full_name, :name, :name_en, :name_ru, :title]
  config.localize_format = :active_admin
  config.logout_link_method = :delete
  config.site_title_link = "/"
end
