# frozen_string_literal: true

# Instance counter to save instances
# inside off class variables
module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  # to be class methods
  module ClassMethods
    def all
      @@all ||= {}
    end

    def find(name)
      all[name]
    end

    def instances
      instances_number
    end

    def instances_number
      all.keys.size
    end
  end

  # InstanceMethods
  module InstanceMethods
    def register_instance
      self.class.all[name] = self
    end
  end
end
