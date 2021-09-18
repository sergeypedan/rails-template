# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
[
  'node_modules',
  'vendor/assets/fonts',
  'vendor/assets/images',
  'vendor/assets/plugins',
  'vendor/assets/templates'
].each { |relative_path|
  Rails.application.config.assets.paths << Rails.root.join(relative_path).to_s
}

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
#
# manifest.js is included by itself
# Rails.application.config.assets.precompile << "manifest.js"


# Rails.application.config.assets.configure do |env|
  # env.gzip = :zopfli
  # https://github.com/le0pard/zopfli-ffi
  # https://github.com/pludoni/compression-binaries-gem
  # https://github.com/miyucy/brotli
  # https://github.com/rails/sprockets/blob/master/guides/building_an_asset_processing_framework.md
# end
