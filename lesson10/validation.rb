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
  def validate!
    validations = self.class.class_variable_get(:@@validations)

    validations.each do |v|
      field_name       = v[0]
      field_validation = v[1]
      field_extra_data = v[2]

      instance_var = instance_variable_get("@#{field_name}")

      case field_validation
      when :presence
        fail "'#{field_name}' should be defined." unless instance_var
      when :format
        fail "'#{field_name}' should correspond to RegExp #{field_extra_data}" unless field_extra_data.match?(instance_var)
      when :type
        fail "'#{field_name}' should be '#{field_extra_data}'" unless field_extra_data == instance_var.class
      end
    end

    true
  end

  def valide?
    validate!
  rescue
    false
  else
    true
  end
end
