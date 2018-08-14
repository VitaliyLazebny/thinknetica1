# Класс Station (Станция):
#
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
#

class Station
  attr_reader :name
  attr_reader :trains

  alias id name

  def initialize(name)
    @name   = name
    @trains = []
  end

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

  # Station.all -> return all instances
  def self.all
    ObjectSpace.each_object(self).to_a
  end
end
