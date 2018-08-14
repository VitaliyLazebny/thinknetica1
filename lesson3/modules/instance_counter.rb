
module InstanceCounter
  def all
    ObjectSpace.each_object(self).to_a
  end

  def find(name)
    self.class.all.detect do |t|
      t.name == name
    end
  end

  # not 'instances' to have clear naming
  def instances_number
    self.all.size
  end

  # no need for 'register_instances' method
end
