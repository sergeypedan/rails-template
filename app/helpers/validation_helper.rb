# frozen_string_literal: true

module ValidationHelper

	def validators_for(record:, attr:, type: nil, option: nil)
		result = record.class.validators
		result = result.select { _1.attributes.include? attr }
		result = result.select { _1.is_a? type } if type.present?
		result = result.select { _1.options.has_key? option } if option.present?
		result
	end

	def validated_maxlengh(record, attr)
		validators_for(record: record, attr: attr, type: ActiveRecord::Validations::LengthValidator, option: :maximum)
			.map { _1.options[:maximum] }.first
	end

	def validated_minlengh(record, attr)
		validators_for(record: record, attr: attr, type: ActiveRecord::Validations::LengthValidator, option: :minimum)
			.map { _1.options[:minimum] }.first
	end

	def validated_presence(record, attr)
		validators_for(record: record, attr: attr, type: ActiveRecord::Validations::PresenceValidator).any?
	end

end
