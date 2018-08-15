module InstanceCounter
  module ClassMethods
    def all
      @@all
    end

    def find(name)
      @@all[name]
    end

    # not 'instances' to have clear naming
    def instances_number
      self.all.keys.size
    end
  end

  module InstanceMethods
    def register_instance
      @@all ||= {}
      @@all[self.name]=self
    end
  end
end
