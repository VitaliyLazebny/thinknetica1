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
    stations: {},
    trains:   {},
    routes:   {},
    coaches:  []
}

loop do
  puts "Please enter command code (1-11):"
  puts " 1. Create station"
  puts " 2. Create train"
  puts " 3. Create route"
  puts " 4. Add station"
  puts " 5. Remove station"
  puts " 6. Set route"
  puts " 7. Add coach"
  puts " 8. Remove coach from train"
  puts " 9. Move train"
  puts "10. List entities"
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

    if    type == 1 # cargo
      global[:trains].push CargoTrain.new(name)
    elsif type == 2 # passenger
      global[:trains].push PassengerTrain.new(name)
    else
      fail 'Incorrect train type was entered.'
    end

    puts "Train '#{global[:trains].name}' was created."

  when 3 # Create route with start and end stations.
    puts "List of stations:"
    global[:stations].each_with_index do |index, station|
      puts "#{index}. #{station.name}"
    end
    puts "Please enter first station number:"
    first_station = gets.chomp.to_i
    fail "Station doesn't exists." if first_station < 0 || first_station > global[:stations].size

    puts "Please enter last station number:"
    last_station  = gets.chomp.to_i
    fail "Station doesn't exists." if last_station < 0 || last_station > global[:stations].size

    global[:routes].push Route.new( global[:stations][first_station], global[:stations][last_station])

    puts "Route #{global[:routes].last.name} was created."

  when 4  # Add station to route
    puts "Please enter route name:"
    route   = gets.chomp
    fail "Route #{route} doesn't exist." unless global[:routes][route]

    puts "Please enter station name:"
    station = gets.chomp
    fail "Route #{route} doesn't exist." unless global[:stations][station]

    global[:routes][route].add_stations([global[:stations][station]])

  when 5 # Remove station Sonechko from Myrna-Zalizna
    station = global[:stations][parsed_command[2].capitalize]
    route   = parsed_command[4].split('-').map(&:capitalize).join('-')

    global[:routes][route].remove_station(station)


  when 6 # Set route to train
    puts "Enter Route name:"


    train = parsed_command.last
    route = global[:routes][parsed_command[2].split('-').map(&:capitalize).join('-')]

    global[:trains][train].set_route(route)

  # Add coach to train R334
  when command.start_with?('add coach to train')
    train = global[:trains][parsed_command[4]]

    if train.type == 'cargo'
      coach = CargoCoach.new
    else
      coach = PassengerCoach.new
    end

    global[:coaches].push coach

    train.add_coach(coach)

  # Train R334 should leave coach
  when command.end_with?('should leave coach')
    train = global[:trains][parsed_command[1]]

    train.leave_coach

  # Train R334 should go to next station
  when command.end_with?('should go to next station')
    train = global[:trains][parsed_command[1]]

    train.go_to_next_station

  # Train R334 should go to previous station
  when command.end_with?('should go to previous station')
    train = global[:trains][parsed_command[1]]

    train.go_to_previous_station

  # List entities
  when command == 'list entities'
    puts global[:stations].values

  # Stop
  when command == 'stop'
    break
  else
    puts "Was entered unknown command."
    puts "Can't parse it.\n\n\n\n\n"
  end
end
