# frozen_string_literal: true

require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
}

Shrine.logger = Rails.logger

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :determine_mime_type, analyzer: :marcel
Shrine.plugin :pretty_location
Shrine.plugin :remove_invalid # remove and delete files that failed validation
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :store_dimensions
Shrine.plugin :validation_helpers
