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
  def valide?
    validate!
  rescue StandardError
    false
  else
    true
  end

  def validate!
    # Name should be String longer then 3 symbols.
    fail 'Name should be String longer then 3 symbols.' if !@name.is_a?(String) || @name.size < 3

    # Station with given name already exist
    fail 'Station with given name already exist.' if self.class.find(@name)
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
    res += " with trains: #{trains.map(&:to_s).join(', ')}" unless trains.empty?

    res
  end

  # Iteration
  def each_train
    @trains.each do |train|
      yield(train)
    end
  end

  def each_train_with_index
    @trains.each_with_index do |index, train|
      yield(index, train)
    end
  end
end
