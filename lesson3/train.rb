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

require_relative 'modules/entity_type'
require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

class Train
  include EntityType
  include Manufacturer
  include InstanceCounter

  attr_reader :speed
  attr_reader :name
  attr_reader :coaches
  attr_reader :route
  attr_reader :current_station

  alias id name
  alias number name

  def initialize(name)
    @name            = name
    @coaches         = []
    @speed           = 0
    @route           = nil
    @current_station = nil

    validate!

    register_instance
  end

  # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  # Validation methods
  def valide?
    validate!
  rescue
    false
  else
    true
  end

  def validate!
    # name should be String.
    fail 'Name should be text string.' unless @name.is_a?(String)

    # Name should be:
    # 3 word characters +
    # optional bar      +
    # 2 word characters
    fail 'Incorrect name format.' unless @name[/^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/]

    # Train with given name already exist
    fail 'Train with given name already exist.' if self.class.find(@name)
  end
  # -   -   -   -   -   -   -   -   -

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
    fail 'No coaches left.' if size.zero?

    @coaches.pop
  end
  # -  -  -  -  -  -  -  -  -  -  -  -  -

  def set_route(route)
    @route           = route
    @current_station = route.first
    @current_station.accept_train self
  end

  def go_to_next_station
    next_station    = @route.next_station(current_station)
    @current_station.send_train self

    @current_station = next_station
    @current_station.accept_train self
  end

  def go_to_previous_station
    @current_station.send_train self

    previous_station = @route.previous_station(current_station)
    @current_station  = previous_station

    @current_station.accept_train self
  end

  def size
    coaches.size
  end

  def to_s
    "Number: '#{name}'. Type: #{type}. Coaches number: #{size}."
  end

  # Iteration
  def each_coach
    @coaches.each do |coach|
      yield(coach)
    end
  end

  def each_coach_with_index
    @coaches.each_with_index do |coach, index|
      yield(index, coach)
    end
  end
  # -  -  -  -  -  -  -  -  -  -  -  -  -
end
