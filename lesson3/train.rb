# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

require_relative 'm_entity_type'

class Train
  include EntityType

  attr_accessor :current_station

  attr_reader   :speed
  attr_reader   :name
  attr_reader   :type
  attr_reader   :coaches

  alias id name

  def initialize(name, type)
    @name            = name
    @type            = type
    @coaches         = []
    @speed           = 0
    @route           = nil
    @current_station = nil
  end

  # -   -   -   -   -   -   -   -   -
  # Speed section
  #
  def increase_speed
    @speed += 1
  end

  def decrase_speed
    @speed -= 1
  end
  # -   -   -   -   -   -   -   -   -

  # -  -  -  -  -  -  -  -  -  -  -  -
  # Coaches section
  #
  def add_coach(coach)
    fail 'Wrong coach type' if type != coach.type

    @coaches.push(coach)
  end

  def leave_coach
    fail 'No coaches left.' if @coaches_number.zero?

    @coaches.pop
  end
  # -  -  -  -  -  -  -  -  -  -  -  -  -

  def set_route(route)
    @route          = route
    current_station = route.first
  end

  def go_to_next_station
    next_station    = @route.next_station(current_station)
    current_station = next_station
  end

  def go_to_previous_station
    previous_station = @route.previous_station(current_station)
    current_station  = previous_station
  end

  def size
    coaches.number
  end

  def to_s
    name
  end
  # -  -  -  -  -  -  -  -  -  -  -  -  -
end
