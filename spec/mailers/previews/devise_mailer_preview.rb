# frozen_string_literal: true

# http://localhost:3000/rails/mailers/
#
class DeviseMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    setup!
    Devise::Mailer.public_send(__method__, @user, @token, {})
  end

  def email_changed
    setup!
    Devise::Mailer.public_send(__method__, @user, {})
  end

  def password_change
    setup!
    Devise::Mailer.public_send(__method__, @user, {})
  end

  def reset_password_instructions
    setup!
    Devise::Mailer.public_send(__method__, @user, @token, {})
  end

  def unlock_instructions
    setup!
    Devise::Mailer.public_send(__method__, @user, @token, {})
  end

  private

  def setup!
    fail StandardError, "Для работы этого Mailer::Preview нужен как минимум 1 User с пользователем" if User.none?
    @user = User.first
    @user.update(email: "test@test.com") if @user.email.blank?
    @token = "faketoken"
  end

end
