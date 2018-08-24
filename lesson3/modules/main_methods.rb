def create_station(global)
  puts 'Please enter station name:'
  puts '(case sensitive)'
  station_name = gets.chomp

  station = Station.new(station_name)
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:stations].push station
  puts "Station '#{station_name}' was created."
end # create_station(global)

def create_train(global)
  puts 'Please enter train name:'
  puts '(case sensitive)'
  name = gets.chomp

  puts 'Please enter train type:'
  puts '1. Cargo'
  puts '2. Passenger'
  type = gets.chomp.to_i
  fail 'Incorrect train type was entered.' unless [1,2].include? type

  if    type == 1 # cargo
    train = CargoTrain.new(name)
  else # passenger
    train = PassengerTrain.new(name)
  end

rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:trains].push train
  puts "Train '#{train.name}' was created."
end # create_train(global)

def create_route(global)
  fail "Route can be created only if there's 2 or more stations." if global[:stations].size < 2

  puts 'List of stations:'
  global[:stations].each_with_index do |station, index|
    puts "#{index}. #{station.name}"
  end

  puts 'Please enter first station number:'
  first_station = gets.chomp.to_i
  fail "Station doesn't exists." if first_station < 0 || first_station > global[:stations].size - 1

  puts 'Please enter last station number:'
  last_station  = gets.chomp.to_i
  fail "Station doesn't exists." if last_station < 0 || last_station > global[:stations].size - 1

  fail "Route can't be started and ended with the same station." if first_station == last_station
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:routes].push Route.new( global[:stations][first_station], global[:stations][last_station])
  puts "Route #{global[:routes].last.name} was created."
end # create_route(global)

def add_station_to_route(global)
  fail 'No routes added to system' if global[:routes].size < 1

  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end

  puts 'Please enter route number:'
  route   = gets.chomp.to_i
  fail "Route #{route} doesn't exist." if route < 0 || route > global[:routes].size - 1

  puts 'List of stations:'
  global[:stations].each_with_index do |station, index|
    puts "#{index}. #{station.name}"
  end

  puts 'Please enter station number:'
  station = gets.chomp.to_i
  fail "Route #{station} doesn't exist." if station < 0 || station > global[:stations].size - 1
  fail "Route #{global[:routes][route].name} already contains " +
           "Station #{global[:stations][station].name}" if global[:routes][route].stations.include? global[:stations][station]
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:routes][route].add_stations [global[:stations][station]]
  puts 'Station was successfully added to Route.'
end # add_station_to_route(global)

def remove_station_from_route(global)
  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end

  puts 'Please enter route number:'
  route   = gets.chomp.to_i
  fail "Route #{route} doesn't exist." if route < 0 || route > global[:routes].size - 1
  fail "Station can't be removed since" +
           ' route contains only 2 station (first and last).' if global[:routes][route].stations.size < 3

  puts 'List of stations:'
  global[:routes][route].stations.each_with_index do |station, index|
    puts "#{index}. #{station.name}"
  end

  puts 'Please enter station number:'
  station = gets.chomp.to_i
  fail "Station #{station} absent in this route." if station < 0 || station > global[:routes][route].stations.size - 1
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:routes][route].remove_station global[:routes][route].stations[station]
  puts "Station #{global[:stations][station].name} from route #{global[:routes][route].name} was successfully removed."
end # remove_station_from_route(global)

def set_route_to_train(global)
  fail "There's no routes to assign." if global[:routes].size < 1

  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end

  puts 'Please enter route number:'
  route   = gets.chomp.to_i
  fail "Route #{route} doesn't exist." if route < 0 || route > global[:routes].size - 1

  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train   = gets.chomp.to_i
  fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  global[:trains][train].set_route global[:routes][route]
  puts "Route #{global[:routes][route].name} was set to #{global[:trains][train].name} "
end

def add_coach_to_train
  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train   = gets.chomp.to_i
  fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1

  train = global[:trains][train]

  coach = if train.type == 'cargo'
            CargoCoach.new
          else
            PassengerCoach.new
          end

  global[:coaches].push coach
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  train.add_coach(coach)
  puts "Coach was successfully added to train #{train.name}."
end

def train_leave_coach(global)
  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train = gets.chomp.to_i
  fail "Route '#{train}' doesn't exist." if train < 0 || train > global[:trains].size - 1

  train = global[:trains][train]
rescue => ex
  puts "Error: #{ex.message}"
  retry
else
  train.leave_coach
  puts "Coach was successfully leaved by train #{train.name}."
end

def train_went_station(global)
  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train   = gets.chomp.to_i
  fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1

  train = global[:trains][train]
  fail "Train #{train.name} doesn't have assigned route and station." if train.route.nil? || train.current_station.nil?

  puts 'Directions:'
  puts '1. Next station'
  puts '2. previous station'
  puts 'Please enter direction number:'
  direction = gets.chomp.to_i
  fail 'Direction not applicable.' unless [1,2].include?(direction)

  if direction == 1
    train.go_to_next_station
  else
    train.go_to_previous_station
  end
  puts "Train #{train.name} changed location to #{direction == 1 ? 'next' : 'previous'} station."
end

def list_stations(global)
  if global[:stations].size > 0
    puts 'List of stations:'
    global[:stations].each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end
  else
    puts "There's no Stations created."
    return
  end

  puts 'Please enter station number:'
  station = gets.chomp.to_i
  fail "Station #{station} doesn't exist." if station < 0 || station > global[:stations].size - 1

  if global[:stations][station].trains.size > 0
    puts 'List of trains on station:'
    global[:stations][station].trains.each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end
    puts '...All trains from chosen station were displayed.'
  else
    puts "There's no trains on this station."
  end

rescue => ex
  puts "Error: #{ex.message}"
  retry
end

def stop_executing(global)
  puts 'Exiting from program.'
  exit
end

def unknown_command(global)
  puts 'Was entered unknown command.'
  puts "Can't parse it.\n\n\n\n\n"
end
