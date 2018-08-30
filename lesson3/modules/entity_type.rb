# frozen_string_literal: true

# Get Type from class name
module EntityType
  def type
    self.class.to_s.split(/(?=[A-Z])/).first.downcase
  end
end
