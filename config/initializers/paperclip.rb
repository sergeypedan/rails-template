# https://github.com/thoughtbot/paperclip/blob/master/lib/paperclip/attachment.rb#L13
# https://www.rubydoc.info/gems/paperclip/Paperclip/Storage/S3

options = Paperclip::Attachment.default_options

# Local
options[:storage] = :filesystem
options[:url]     = "/uploads/:class/:id/:style.:extension"
options[:path]    = ":rails_root/public:url"

# AWS
options[:bucket]         = Rails.application.credentials.dig(:aws, :s3, :bucket)
# options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
options[:path]           = "#{Rails.env}/:class/:id/:style.:extension"
options[:s3_credentials] = {
  access_key_id:     Rails.application.credentials.dig(:aws, :s3, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :s3, :secret_access_key)
}
# options[:s3_host_name]   = 's3-us-west-2.amazonaws.com'
options[:s3_protocol] = :https
options[:s3_region]   = Rails.application.credentials.dig(:aws, :s3, :region)
options[:s3_storage_class] = :REDUCED_REDUNDANCY
options[:storage]     = :s3
options[:url]         = ":s3_domain_url"
