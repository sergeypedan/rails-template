# frozen_string_literal: true

# Relies on gem
# gem "burner_email_db"
class BurnerEmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute_name, address)
    return if address.blank? # validate presence separately
    record.errors.add attribute_name, :disposable_email if disposable?(address)
  end

  private def disposable?(address)
    BurnerEmailDB.domains.any? { |burner_domain| address.include? burner_domain }
  end

end

# ru:
#   errors:
#     messages:
#       disposable_email: в сервисе одноразовых email-адресов
