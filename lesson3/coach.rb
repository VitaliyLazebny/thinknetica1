# frozen_string_literal: true

# abstract Coach
#
require_relative 'modules/entity_type'
require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

# 'Abstract' Coach
#
class Coach
  include EntityType
  include Manufacturer
end
