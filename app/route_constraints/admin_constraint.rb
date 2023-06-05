# frozen_string_literal: true

class AdminConstraint

	def matches?(request)
		user_class    = AdminUser
		return unless cookie_value  = request.session["warden.user.#{user_class.model_name.singular}.key"]
		return unless user_id       = Array(cookie_value).flatten.first
		return unless password_salt = Array(cookie_value).flatten.second
		@has_admin_user ||= !!user_class.serialize_from_session(user_id, password_salt)
	end
end
