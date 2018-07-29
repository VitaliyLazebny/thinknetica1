#
# Get Type from class name
#
module EntityType
  def type
    self.class.to_s.split(/(?=[A-Z])/).first.downcase
  end
end
