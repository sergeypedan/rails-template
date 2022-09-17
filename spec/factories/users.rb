# frozen_string_literal: true

FactoryBot.define do
  factory :user do
  	confirmed_at { Time.current - 1.minute }
    email        { Faker::Internet.email(domain: "gmail.com") }
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    password     { Faker::Internet.password(min_length: 10) }
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string           indexed
#  confirmed_at           :datetime
#  email                  :string           not null, indexed
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string(50)       not null
#  full_name              :string(100)
#  last_name              :string(50)       not null
#  locked_at              :datetime
#  photo_data             :jsonb
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  role                   :string           default("user"), not null
#  uid                    :string(20)       not null, indexed
#  unconfirmed_email      :string
#  unlock_token           :string           indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
