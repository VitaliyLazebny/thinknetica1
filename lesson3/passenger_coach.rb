# frozen_string_literal: true

class PassengerCoach < Coach
  attr_reader :total_places
  attr_reader :occupied_places

  def initialize(total)
    unless total.is_a?(Integer) && total > 0
      raise 'Total number of places should be integer bigger then 0.'
    end

    @total_places    = total
    @occupied_places = 0
  end

  def available_places
    @total_places - @occupied_places
  end

  def occupy_place
    raise 'All places was already occupied.' if available_places.zero?

    @occupied_places += 1
  end

  def to_s
    "Type: #{type}. Available places: #{available_places}. Occupied places: #{occupied_places}"
  end
end
