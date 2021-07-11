# frozen_string_literal: true

class PhoneValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		return if value.blank? # presence should be checked separately
		TZInfo::Timezone.get(value)
	rescue TZInfo::InvalidTimezoneIdentifier
		errors.add(:timezone_name, 'имеет значение, которого нет в списке существующих часовых поясов')
	end

end
