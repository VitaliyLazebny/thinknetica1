# frozen_string_literal: true

require_relative 'user_interaction'

def create_station(global)
  puts 'Please enter station name:'
  puts '(case sensitive)'
  station_name = gets.chomp

  station = Station.new(station_name)
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:stations].push station
  puts "Station '#{station_name}' was created."
end

def create_train(global)
  name, type = ask_train_data

  train = type == 1 ? CargoTrain.new(name) : PassengerTrain.new(name)

  global[:trains].push train
  puts "Train '#{train.name}' was created."
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def create_route(global)
  stations = ask_route_data(global)

  global[:routes].push(Route.new(*stations))
  puts "Route #{global[:routes].last.name} was created."
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def add_station_to_route_dialog(global)
  validate_route_present!(global)
  display_routes(global)
  route = ask_route_id(global)
  display_stations(global)
  ask_station('Please enter station number:', global)
  validate_station_for_route(global[:routes][route], global[:stations][station])
  add_station_to_route(global[:routes][route], global[:stations][station])
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def remove_station_from_route(global)
  raise 'No routes added to system' if global[:routes].empty?
  route = ask_route_id(global)
  validate_stations_more_then_2!(global[:routes][route])
  station = ask_station('Please enter station number:', global)
  global[:routes][route].remove_station global[:routes][route].stations[station]
  puts "Station #{global[:stations][station].name} "\
       "from route #{global[:routes][route].name} "\
       'was successfully removed.'
end

# @param [Object] global
def route_for_train(global)
  raise "There's no trains created."   if Train.all.size.zero?
  raise "There's no routes to assign." if global[:routes].empty?

  route = ask_route_id(global)
  train = ask_train_id(global)

  global[:trains][train].route = global[:routes][route]
  puts "Route #{global[:routes][route].name} was"\
       " set to #{global[:trains][train].name} "
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def add_coach_to_train(global)
  raise "There's no trains created." if Train.all.size.zero?

  display_trains(global)

  train = ask_train_id(global)
  train = global[:trains][train]

  create_coach(train, global)

  puts "Coach was successfully added to train #{train.name}."
rescue StandardError => ex
  puts "Error: #{ex.message}, #{ex.backtrace}"
  retry
end

def train_leave_coach(global)
  raise "There's no trains created." if Train.all.size.zero?

  display_trains(global)

  train = ask_train_id(global)

  train = global[:trains][train]

  train.leave_coach
  puts "Coach was successfully left by train #{train.name}."
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def train_went_station(global)
  train = find_train_in_global(global)

  direction = get_direction(global)

  if direction == 1
    train.go_to_next_station
  else
    train.go_to_previous_station
  end
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def occupy_coach_space(global)
  find_coach_in_trains(global)

  if coach.type == 'cargo'
    coach.occupy_volume
  else
    coach.occupy_place
  end

  puts 'Coach space was successfully occupied.'
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def list_stations(global)
  display_stations(global)

  ask_station(
    'Please enter station number:',
    global
  )
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def stop_executing(_global)
  puts 'Exiting from program.'
  exit
end

def unknown_command(_global)
  puts 'Was entered unknown command.'
  puts "Can't parse it.\n\n\n\n\n"
end
