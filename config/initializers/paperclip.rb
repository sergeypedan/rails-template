# https://github.com/thoughtbot/paperclip/blob/master/lib/paperclip/attachment.rb#L13

options = Paperclip::Attachment.default_options

# Local
options[:storage] = :filesystem
options[:url]     = "/uploads/:class/:id/:style.:extension"
options[:path]    = ":rails_root/public:url"

# AWS
options[:storage] = :s3
options[:s3_credentials] = {
  bucket: ENV['AWS_BUCKET'],
  access_key_id: ENV["AWS_KEY_ID"],
  secret_access_key: ENV["AWS_ACCESS_KEY"],
  s3_region: ENV['AWS_REGION']
}
options[:path] = "#{Rails.env}/:class/:id/:style.:extension"
options[:url] = ":s3_domain_url"
