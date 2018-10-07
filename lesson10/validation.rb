# validate :name, :presence
# validate :number, :format, /A-Z{0,3}/
# validate :station, :type, RailwayStation
# validate :name, :presence
# validate :name, :format, /A-Z/
# validate :name, :type, String

module Validation
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  # class method to add validation
  module ClassMethods
    def validate(*args)
      class_variable_set(:@@validations, []) unless class_variable_defined?(:@@validations)

      class_variable_get(:@@validations).push args
    end
  end

  # instance methods
  def valid?
    validations = class_variable_get(:@@validations)

    validations.each do |v|
      field_name       = v[0]
      field_validation = v[1]
      field_extra_data = v[2]



      return false, v
    end

    true
  end

  def validate!
    raise unless valid?
  end
end
