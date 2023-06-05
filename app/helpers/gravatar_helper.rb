# frozen_string_literal: true

module GravatarHelper

	def gravatar_for(email, size)
		"https://www.gravatar.com/avatar/" + Digest::MD5.hexdigest(email) + "?s=" + size
	end

end
