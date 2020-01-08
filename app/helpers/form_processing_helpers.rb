# frozen_string_literal: true

module FormParamHelpers

  include FnValidations

  def checkbox_value_to_bool_or_nil(value)
    return nil if value.nil?
    return value if [TrueClass, FalseClass].include? value.class
    [1, "1"].include? value
  end

  def extract_attributes_from_ACParams_or_Hash(hash_or_params, param_key, supported_attributes)
    validate_argument_type! hash_or_params, [Hash, ActionController::Parameters]
    params     = hash_or_params.is_a?(Hash) ? ActionController::Parameters.new(hash_or_params) : hash_or_params
    attributes = params.require(param_key).permit(*supported_attributes).to_h rescue {}
    return attributes.deep_symbolize_keys
  end

end
