# frozen_string_literal: true

class User < ApplicationRecord

  GENDERS = %w[male female].freeze


  # Scopes

  scope :for_select, -> { order(:last_name, :first_name).select("CONCAT(users.id, ' - ', users.last_name, ' ', users.first_name) as name, users.id") }


  # Callbacks

  before_validation :normalize_email!
  before_create     :generate_uid!


  # Validations

  validates :email,      presence: true, email: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :gender,     allow_blank: true, inclusion: { in: GENDERS }


  # Macros

  acts_as_list scope: :course, top_of_list: 0


  # Methods

  def age
     ((Time.current - date_of_birth.to_time) / 1.year).floor if date_of_birth
  end

  def full_name
    [first_name, last_name].map(&:presence).join(" ")
  end

  def full_name=(value)
    self.first_name, self.first_name = value.squish.split(" ")
  end

  def generate_password!
    self.password = SecureRandom.hex(15)
    # `self.password ||= ` нельзя, потому что `@user.password` всегда отвечает `nil`
  end

  def generate_uid!
    self.uid = loop do
      random_token = 'u' + SecureRandom.alphanumeric(10)
      break random_token unless self.class.exists?(uid: random_token)
    end
  end

  private

  def normalize_email!
    self.email = email.to_s.squish
    self.email = email.blank? ? nil : email.downcase
  end

end
