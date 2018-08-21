module InstanceCounter
  module ClassMethods
    @@all = {}

    def all
      @@all
    end

    def find(name)
      @@all[name]
    end

    def instances
      instances_number
    end

    def instances_number
      self.all.keys.size
    end
  end

  module InstanceMethods
    def register_instance
      self.class.all[self.name]=self
    end
  end
end
