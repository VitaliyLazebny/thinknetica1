# Класс Station (Станция):
#
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
#

require_relative 'modules/instance_counter'

class Station
  include InstanceCounter

  attr_reader :name
  attr_reader :trains

  alias id name

  def initialize(name)
    @name   = name
    @trains = []

    validate!

    register_instance
  end

  # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  # Validation methods
  def validate!
    fail 'Invalid class data was entered.' unless valid?
  end

  def valid?
    # Name should be:
    # 3 word characters +
    # optional bar      +
    # 2 word characters
    return false if !@name.is_a?(String) || @name.size < 3

    # Station with given name already exist
    return false if self.class.find(@name)

    true
  end
  # -   -   -   -   -   -   -   -   -

  def accept_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def to_s
    res  = "Station '#{name}'"
    res +=" with trains: #{trains.map(&:to_s).join(', ')}" unless trains.empty?

    res
  end


end
