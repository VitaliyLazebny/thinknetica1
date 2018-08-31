# frozen_string_literal: true

def show_commands_list(_global)
  list = ['Please enter command code (1-11):', ' 1. Create station',
          ' 2. Create train', ' 3. Create route',
          ' 4. Add station to route', ' 5. Remove station',
          ' 6. Set route', ' 7. Add coach', ' 8. Remove coach from train',
          ' 9. Move train', '10. Occupy coach space',
          '11. List stations and trains on station',
          '12. Exit from program']

  puts list.join("\n")
  puts "\n\n\n"
end

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

def ask_train_data
  puts 'Please enter train name:'
  puts '(case sensitive)'
  name = gets.chomp

  puts 'Please enter train type:'
  puts '1. Cargo'
  puts '2. Passenger'
  type = gets.chomp.to_i
  raise 'Incorrect train type was entered.' unless [1, 2].include? type

  [name, type]
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

def ask_station(global)
  station = gets.chomp.to_i
  if station.negative? || station > global[:stations].size - 1
    raise "Station doesn't exists."
  end

  global[:stations][station]
end

def display_stations(global)
  if global[:stations].empty?
    puts "There's no Stations created."
    return
  end

  puts 'List of stations:'
  global[:stations].each_with_index do |station, index|
    puts "#{index}. #{station.name}"
  end
end

def ask_route_data(global)
  if global[:stations].size < 2
    raise "Route can be created only if there's 2 or more stations."
  end

  display_stations(global)

  puts 'Please enter first station number:'
  first_station = ask_station(global)

  puts 'Please enter last station number:'
  last_station = ask_station(global)

  if first_station == last_station
    raise 'Route can\'t be started and ended with the same station.'
  end

  [first_station, last_station]
end

def create_route(global)
  stations = ask_route_data(global)

  global[:routes].push(*Route.new(stations))
  puts "Route #{global[:routes].last.name} was created."
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def add_station_to_route(global)
  raise 'No routes added to system' if global[:routes].empty?

  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end

  puts 'Please enter route number:'
  route = gets.chomp.to_i
  if route.negative? || route > global[:routes].size - 1
    raise "Route #{route} doesn't exist."
  end

  display_stations(global)

  puts 'Please enter station number:'
  ask_station(global)

  if global[:routes][route].stations.include? global[:stations][station]
    raise "Route #{global[:routes][route].name} already contains "\
          "Station #{global[:stations][station].name}"
  end

  global[:routes][route].add_stations [global[:stations][station]]
  puts 'Station was successfully added to Route.'
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def remove_station_from_route(global)
  raise 'No routes added to system' if global[:routes].empty?
  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end

  puts 'Please enter route number:'
  route = gets.chomp.to_i
  if route.negative? || route > global[:routes].size - 1
    raise "Route #{route} doesn't exist."
  end

  if global[:routes][route].stations.size < 3
    raise "Station can't be removed since" \
         ' route contains only 2 station (first and last).'
  end

  puts 'List of stations:'
  global[:routes][route].stations.each_with_index do |station, index|
    puts "#{index}. #{station.name}"
  end

  puts 'Please enter station number:'
  station = gets.chomp.to_i
  if station.negative? || station > global[:routes][route].stations.size - 1
    raise "Station #{station} absent in this route."
  end

  global[:routes][route].remove_station global[:routes][route].stations[station]
  puts "Station #{global[:stations][station].name} "\
       "from route #{global[:routes][route].name} "\
       'was successfully removed.'
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def route_for_train(global)
  raise "There's no trains created."   if Train.all.size.zero?
  raise "There's no routes to assign." if global[:routes].empty?

  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end

  puts 'Please enter route number:'
  route = gets.chomp.to_i
  if route.negative? || route > global[:routes].size - 1
    raise "Route #{route} doesn't exist."
  end

  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train = gets.chomp.to_i
  if train.negative? || train > global[:trains].size - 1
    raise "Route #{train} doesn't exist."
  end

  global[:trains][train].route = global[:routes][route]
  puts "Route #{global[:routes][route].name} was"\
       " set to #{global[:trains][train].name} "
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def add_coach_to_train(global)
  raise "There's no trains created." if Train.all.size.zero?

  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train = gets.chomp.to_i
  if train.negative? || train > global[:trains].size - 1
    raise "Train #{train} doesn't exist."
  end

  train = global[:trains][train]

  coach = if train.type == 'cargo'
            puts 'Please enter volume amount:'
            volume = gets.chomp

            raise 'Volume should be Integer.' unless volume.to_i.to_s == volume

            unless volume.to_i.positive?
              raise 'Volume should be larger then zero.'
            end

            volume = volume.to_i
            CargoCoach.new(volume)
          else
            puts 'Please enter places number:'
            places = gets.chomp.to_i

            if places.to_i.to_s == places
              raise 'Places number should be Integer.'
            end
            unless places.to_i.positive?
              raise 'Places number should be positive.'
            end

            places = places.to_i
            PassengerCoach.new(places)
          end

  global[:coaches].push coach

  train.add_coach(coach)
  puts "Coach was successfully added to train #{train.name}."
rescue StandardError => ex
  puts "Error: #{ex.message}, #{ex.backtrace}"
  retry
end

def train_leave_coach(global)
  raise "There's no trains created." if Train.all.size.zero?

  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train = gets.chomp.to_i
  if train.negative? || train > global[:trains].size - 1
    raise "Route '#{train}' doesn't exist."
  end

  train = global[:trains][train]

  train.leave_coach
  puts "Coach was successfully leaved by train #{train.name}."
rescue StandardError => ex
  puts "Error: #{ex.message}"
  retry
end

def train_went_station(global)
  raise "There's no trains created." if Train.all.size.zero?

  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end

  puts 'Please enter train number:'
  train = gets.chomp.to_i
  if train.negative? || train > global[:trains].size - 1
    raise "Route #{train} doesn't exist."
  end

  train = global[:trains][train]
  unless train.route && train.current_station
    raise "Train #{train.name} doesn't have assigned route and station."
  end

  puts 'Directions:'
  puts '1. Next station'
  puts '2. previous station'
  puts 'Please enter direction number:'
  direction = gets.chomp.to_i
  raise 'Direction not applicable.' unless [1, 2].include?(direction)

  if direction == 1
    train.go_to_next_station
  else
    train.go_to_previous_station
  end
  puts "Train #{train.name} changed location to"\
       "#{direction == 1 ? 'next' : 'previous'} station."
end

def occupy_coach_space(global)
  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train}"
  end

  puts 'Please choose train:'
  train_number = gets.chomp.to_i
  if train_number.negative? || train_number > global[:trains].size - 1
    raise 'Invalid train selected.'
  end

  train = global[:trains][train_number]

  puts 'Coaches list:'
  train.each_coach_with_index do |index, coach|
    puts "#{index}. #{coach}."
  end

  raise 'Train has no coaches.' if train.size.zero?

  puts 'Please select the coach:'
  coach_number = gets.chomp.to_i

  if coach_number.negative? || coach_number > train.size - 1
    raise 'Invalid coach selected.'
  end
  coach = train.coaches[coach_number]

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
  if !global[:stations].empty?
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
  if station.negative? ||
     station > global[:stations].size - 1

    raise "Station #{station} doesn't exist."
  end

  if !global[:stations][station].trains.empty?
    puts 'List of trains on station:'
    global[:stations][station].each_train_with_index do |index_t, train|
      puts "#{index_t}. #{train.name}"
      puts 'List of Coaches:'
      train.each_coach_with_index do |index_c, coach|
        puts "#{coach}. #{index_c}"
      end
    end
    puts '...All trains from chosen station were displayed.'
  else
    puts "There's no trains on this station."
  end
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
