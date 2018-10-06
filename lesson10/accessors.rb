module Accessors
  def attr_accessor_with_history(names)
    names.each do |name|
      name = name.to_sym

      # create empty history for variable
      instance_variable_set(name, [])

      define_method("#{name}=") do |value|
        instance_variable_get(name).push value
      end

      define_method(name) do
        instance_variable_get(name).last
      end

      define_method("#{name}_history") do
        instance_variable_get(name)
      end
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
