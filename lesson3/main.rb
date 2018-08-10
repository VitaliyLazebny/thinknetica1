#
# Text interface to railway facilities
#
# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#      - Создавать станции
#      - Создавать поезда
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции
#
require_relative 'route'
require_relative 'station'

require_relative 'cargo_train'
require_relative 'passenger_train'

require_relative 'cargo_coach'
require_relative 'passenger_coach'


# Commands should not be hardcoded.
global = {
    stations: [],
    trains:   [],
    routes:   [],
    coaches:  []
}

loop do
  puts "Please enter command code (1-11):"
  puts " 1. Create station"
  puts " 2. Create train"
  puts " 3. Create route"
  puts " 4. Add station to route"
  puts " 5. Remove station"
  puts " 6. Set route"
  puts " 7. Add coach"
  puts " 8. Remove coach from train"
  puts " 9. Move train"
  puts "10. List stations and trains on station"
  puts "11. Exit from programm\n\n"

  command = gets.chomp.to_i

  case command
  when 1 # create station
    puts "Please enter station name:"
    puts "(case sensitive)"
    station_name = gets.chomp

    global[:stations].push Station.new(station_name)

    puts "Station #{station_name} was created."

  when 2 # Create train
    puts "Please enter train name:"
    puts "(case sensitive)"
    name = gets.chomp

    puts "Please enter train type:"
    puts "1. Cargo"
    puts "2. Passenger"
    type = gets.chomp.to_i
    fail 'Incorrect train type was entered.' unless [1,2].include? type

    if    type == 1 # cargo
      train = CargoTrain.new(name)
    else # passenger
      train = PassengerTrain.new(name)
    end

    global[:trains].push train
    puts "Train '#{train.name}' was created."

  when 3 # Create route with start and end stations.
    fail "Route can be created only if there's 2 or more stations." if global[:stations].size < 2

    puts "List of stations:"
    global[:stations].each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end

    puts "Please enter first station number:"
    first_station = gets.chomp.to_i
    fail "Station doesn't exists." if first_station < 0 || first_station > global[:stations].size - 1

    puts "Please enter last station number:"
    last_station  = gets.chomp.to_i
    fail "Station doesn't exists." if last_station < 0 || last_station > global[:stations].size - 1

    fail "Route can't be started and ended with the same station." if first_station == last_station

    global[:routes].push Route.new( global[:stations][first_station], global[:stations][last_station])
    puts "Route #{global[:routes].last.name} was created."

  when 4  # Add station to route
    fail "No routes added to system" if global[:routes].size < 1

    puts "Routes list:"
    global[:routes].each_with_index do |route, index|
      puts "#{index}. #{route.name}"
    end

    puts "Please enter route number:"
    route   = gets.chomp.to_i
    fail "Route #{route} doesn't exist." if route < 0 || route > global[:routes].size - 1

    puts "List of stations:"
    global[:stations].each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end

    puts "Please enter station number:"
    station = gets.chomp.to_i
    fail "Route #{station} doesn't exist." if station < 0 || station > global[:stations].size - 1
    fail "Route #{global[:routes][route].name} already contains " +
         "Station #{global[:stations][station].name}" if global[:routes][route].stations.include? global[:stations][station]

    global[:routes][route].add_stations [global[:stations][station]]
    puts "Station was successfully added to Route."

  when 5 # Remove station from route
    puts "Routes list:"
    global[:routes].each_with_index do |route, index|
      puts "#{index}. #{route.name}"
    end

    puts "Please enter route number:"
    route   = gets.chomp.to_i
    fail "Route #{route} doesn't exist." if route < 0 || route > global[:routes].size - 1
    fail "Station can't be removed since" +
         " route contains only 2 station (first and last)." if global[:routes][route].stations.size < 3

    puts "List of stations:"
    global[:routes][route].stations.each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end

    puts "Please enter station number:"
    station = gets.chomp.to_i
    fail "Station #{station} absent in this route." if station < 0 || station > global[:routes][route].stations.size - 1

    global[:routes][route].remove_station global[:routes][route].stations[station]
    puts "Station #{global[:stations][station].name} from route #{global[:routes][route].name} was successfully removed."

  when 6 # Set route to train
    fail "There's no routes to assign." if global[:routes].size < 1

    puts "Routes list:"
    global[:routes].each_with_index do |route, index|
      puts "#{index}. #{route.name}"
    end

    puts "Please enter route number:"
    route   = gets.chomp.to_i
    fail "Route #{route} doesn't exist." if route < 0 || route > global[:routes].size - 1

    puts "Trains list:"
    global[:trains].each_with_index do |train, index|
      puts "#{index}. #{train.name}"
    end

    puts "Please enter train number:"
    train   = gets.chomp.to_i
    fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1

    global[:trains][train].set_route global[:routes][route]
    puts "Route #{global[:routes][route].name} was set to #{global[:trains][train].name} "

  when 7  # Add coach to train
    puts "Trains list:"
    global[:trains].each_with_index do |train, index|
      puts "#{index}. #{train.name}"
    end

    puts "Please enter train number:"
    train   = gets.chomp.to_i
    fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1

    train = global[:trains][train]

    if train.type == 'cargo'
      coach = CargoCoach.new
    else
      coach = PassengerCoach.new
    end

    global[:coaches].push coach

    train.add_coach(coach)
    puts "Coach was successfully added to train #{train.name}."

  when 8 # Train R334 should leave coach
    puts "Trains list:"
    global[:trains].each_with_index do |train, index|
      puts "#{index}. #{train.name}"
    end

    puts "Please enter train number:"
    train   = gets.chomp.to_i
    fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1

    train = global[:trains][train]

    train.leave_coach
    puts "Coach was successfully leaved by train #{train.name}."

  when 9 # Train R334 should go to next station
         # Train R334 should go to previous station
    puts "Trains list:"
    global[:trains].each_with_index do |train, index|
      puts "#{index}. #{train.name}"
    end

    puts "Please enter train number:"
    train   = gets.chomp.to_i
    fail "Route #{train} doesn't exist." if train < 0 || train > global[:trains].size - 1

    train = global[:trains][train]
    fail "Train #{train.name} doesn't have assigned route and station." if train.route.nil? || train.current_station.nil?

    puts "Directions:"
    puts "1. Next station"
    puts "2. previous station"
    puts "Please enter direction number:"
    direction   = gets.chomp.to_i
    fail 'Direction not applicable.' unless [1,2].include?(direction)

    if direction == 1
      train.go_to_next_station
    else
      train.go_to_previous_station
    end
    puts "Train #{train.name} changed location to #{direction == 1 ? 'next' : 'previous'} station."

  when 10 # List stations and trains on station
    puts "List of stations:"
    global[:stations].each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end

    puts "Please enter station number:"
    station = gets.chomp.to_i
    fail "Route #{station} doesn't exist." if station < 0 || station > global[:stations].size - 1

    puts "List of trains on station:"
    global[:stations][station].trains.each_with_index do |station, index|
      puts "#{index}. #{station.name}"
    end
    puts "\n\n\nAll trains from chosen station were displayed."

  when 11 # Stop
    puts 'Exiting from program.'
    break
  else
    puts 'Was entered unknown command.'
    puts "Can't parse it.\n\n\n\n\n"
  end
end
