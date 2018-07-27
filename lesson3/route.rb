# Класс Route (Маршрут):
#
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  def initialize(first_station, last_station, intermediate_stations = nil)
    @stations = [first_station, last_station]

    add_stations(intermediate_stations) if intermediate_stations
  end

  def stations
    @stations
  end

  def add_stations(stations)
    stations.each do |station|
      station.insert(-1, station)
    end
  end

  def remove_station(station)
    @stations.delete_if do |s|
      s.id == station.id
    end
  end

  def get_current_station_index(station)
    @stations.find_index do |s|
      s.id == station.id
    end
  end

  def get_next_station(station)
    current_index = get_current_station_index(station)

    return @stations[current_index] if current_index == size

    @stations[current_index + 1]
  end

  def get_previous_station(station)
    current_index = get_current_station_index(station)

    return @stations[0] if current_index.zero?

    @stations[current_index - 1]
  end

  def size
    @stations.size
  end
end
