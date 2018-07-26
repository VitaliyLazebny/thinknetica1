# Класс Station (Станция):
#
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
#

class Station
  def initialize(name)
    @name   = name
    @trains = []
  end

  def name
    @name
  end

  def trains_list
    @trains
  end

  def accept_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete_if do |t|
      t.id == train.id
    end
  end
end
