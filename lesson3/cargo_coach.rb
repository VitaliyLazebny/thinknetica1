#
#
#
require_relative 'coach'

class CargoCoach < Coach
  attr_reader :total_volume
  attr_reader :occupied_volume

  def initialize(total)
    unless total.is_a?(Integer) && total > 0
      fail 'Total volume should be integer bigger then 0.'
    end

    @total_volume    = total
    @occupied_volume = 0
  end

  def available_volume
    total_volume - occupied_volume
  end

  def occupy_volume
    fail 'All places was already ocupied.' if available_volume.zero?

    @occupied_volume += 1
  end

  def to_s
    "Type: #{type}. Available volume: #{available_volume}. Ocupied volume: #{occupied_volume}"
  end
end
