# frozen_string_literal: true

# Route
class Route
  ERROR_FEW_TIMES_USED = 'Some stations are added to route few times.'

  attr_reader :stations

  def initialize(first_station, last_station, other_stations = nil)
    @stations = [first_station, last_station]

    add_stations(other_stations) if other_stations

    validate!
  end

  #  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
  # Validation methods
  def valid?
    validate!
  rescue StandardError
    false
  else
    true
  end

  def validate!
    # @stations was filled and all
    # elements should be Stations
    unless stations.empty?
      stations.each do |is|
        raise 'All stations should be Station class.' unless is.is_a?(Station)
      end
    end

    # Stations in route should be uniq
    raise ERROR_FEW_TIMES_USED unless stations.size == stations.uniq.size
  end
  #
  #  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -

  def add_stations(stations_arg)
    # Don't add same stations twice.
    already_added_stations = stations_arg & stations
    unless already_added_stations.empty?
      raise 'Stations ' +
            already_added_stations.map(&:name).join('", "') +
            'were already added.'
    end

    stations.insert(-1, *stations_arg)
  end

  def remove_station(station)
    unless station_index(station)
      raise "Station '#{station.name}' is absent in Route."
    end

    stations.delete(station)
  end

  def station_index(station)
    stations.find_index { |s| s == station }
  end

  def next_station(station)
    current_index = station_index(station)

    return last if station == last

    stations[current_index + 1]
  end

  def previous_station(station)
    current_index = station_index(station)

    return first if station == first

    stations[current_index - 1]
  end

  def first
    stations.first
  end

  def last
    stations.last
  end

  def name
    first.name + '-' + last.name
  end

  def id
    name
  end

  def size
    stations.size
  end
end
