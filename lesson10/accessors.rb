module Accessors
  def attr_accessor_with_history(names)
    names.each do |name|
      name = name.to_sym
      instance_var_name = "@#{name}".to_sym

      define_method("#{name}=") do |value|
        # create empty history for variable
        instance_variable_set(instance_var_name, []) unless instance_variable_defined?(instance_var_name)

        instance_variable_get(instance_var_name).push value
      end

      define_method(name) { instance_variable_get(instance_var_name).last }
      define_method("#{name}_history") { instance_variable_get(instance_var_name) }
    end
  end

  def strong_attr_accessor(name, type)
    name = name.to_sym

    define_method("#{name}=") do |value|
      unless value.class == type
        raise "Invalid variable class."\
        " Got: '#{value.class}' when expected: '#{type}'."
      end

      instance_variable_get(name).push value
    end

    define_method(name) do
      instance_variable_get(name).last
    end
  end
end
