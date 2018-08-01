# Класс Route (Маршрут):
#
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
#
class Route
  attr_reader :stations

  def id
    first_station.id + '-' + last_station.id
  end

  def initialize(first_station, last_station, intermediate_stations = nil)
    @stations = [first_station, last_station]

    add_stations(intermediate_stations) if intermediate_stations
  end

  def add_stations(stations)
    @stations.insert(-1, *stations)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def station_index(station)
    @stations.find_index { |s| s == station }
  end

  def next_station(station)
    current_station_index = station_index(station)

    return @stations[current_index] if current_station_index == size

    @stations[current_index + 1]
  end

  def previous_station(station)
    current_station_index = station_index(station)

    return @stations[0] if current_station_index.zero?

    @stations[current_index - 1]
  end

  def size
    @stations.size
  end
end
