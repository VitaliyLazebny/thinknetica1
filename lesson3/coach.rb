#
# abstract Coach
#
require_relative 'modules/entity_type'
require_relative 'modules/manufacturer'

class Coach
  include EntityType
  include Manufacturer
end
