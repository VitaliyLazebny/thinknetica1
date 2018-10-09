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
    def validate(*args, &block)
      class_variable_set(:@@validations, []) unless class_variable_defined?(:@@validations)

      args[3] = block
      class_variable_get(:@@validations).push args
    end
  end

  # instance methods
  def validate!
    validations = self.class.class_variable_get(:@@validations)

    validations.each do |v|
      field_name, field_validation, field_extra_data, field_custom = v

      instance_var = instance_variable_get("@#{field_name}")

      # will raise exception if validation failed
      send(field_validation, *v, instance_var)
    end

    true
  end

  def presence(field_name, field_validation, field_extra_data, field_custom, instance_var)
    raise "'#{field_name}' should be defined." unless instance_var
  end

  def format(field_name, field_validation, field_extra_data, field_custom, instance_var)
    raise "'#{field_name}' should correspond to RegExp #{field_extra_data}" unless field_extra_data.match?(instance_var)
  end

  def type(field_name, field_validation, field_extra_data, field_custom, instance_var)
    raise "'#{field_name}' should be '#{field_extra_data}'" unless field_extra_data == instance_var.class
  end

  def custom(field_name, field_validation, field_extra_data, field_custom, instance_var)
    instance_exec(instance_var, &field_custom)
  end

  def valide?
    validate!
  rescue RuntimeError
    false
  else
    true
  end
end
