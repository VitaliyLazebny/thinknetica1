#
# abstract Coach
#
require_relative 'modules/entity_type'
require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

class Coach
  include EntityType
  include Manufacturer
  include InstanceCounter

  def initialize
    register_instance
  end
end
