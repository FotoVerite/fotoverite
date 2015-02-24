class AutoPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    skip_validation = value.nil? || (record.password.blank? && record.email_confirmation.blank?)
    unless skip_validation || record.authentication_password == value
      record.errors[attribute] << "is incorrect."
    end
  end
end
