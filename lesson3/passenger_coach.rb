#
#
#
class PassengerCoach < Coach
  attr_reader :total_places
  attr_reader :occupied_places

  def initialize(total)
    unless total.is_a?(Integer) && total > 0
      fail 'Total number of places should be integer bigger then 0.'
    end

    @total_places    = total
    @occupied_places = 0

    super
  end

  def available_places
    @total_places - @occupied_places
  end

  def occupy_place
    fail 'All places was already ocupied.' if occupied_places >= total_places

    @occupied_places += 1
  end
end
