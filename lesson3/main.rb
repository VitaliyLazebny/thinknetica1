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
  puts "What should I do?"
  puts "You can use examples:"
  puts "01. Create station Myrna"
  puts "02. Create cargo train R334"
  puts "03. Create route with Myrna and Zalizna"
  puts "04. Add station Sonechko to Myrna-Zalizna"
  puts "05. Remove station Sonechko from Myrna-Zalizna"
  puts "06. Set route Myrna-Zalizna to train R334"
  puts "07. Add coach to train R334"
  puts "08. Train R334 should leave coach"
  puts "09. Train R334 should go to next station"
  puts "10. Train R334 should go to previous station"
  puts "11. List entities"
  puts "12. Stop\n"

  command = gets.chomp.downcase
  parsed_command = command.split ' '

  case
  # Create station Myrna
  when command.start_with?('create station')
    name = parsed_command[2].capitalize

    global[:stations][name] = Station.new(name)

  # Create cargo train R334
  when parsed_command[0] == 'create' &&
       parsed_command[2] == 'train'

    name = parsed_command[3]
    type = parsed_command[1]

    if (type == 'cargo')
      global[:trains][name] = CargoTrain.new(name)
    else
      global[:trains][name] = PassengerTrain.new(name)
    end

  # Create route with Myrna and Zalizna
  when command.start_with?('create route with')
    first_station = parsed_command[3].capitalize
    last_station  = parsed_command[5].capitalize

    name = first_station + '-' + last_station

    global[:routes][name] = Route.new(
        global[:stations][first_station],
        global[:stations][last_station]
    )

  # Add station Sonechko to Myrna-Zalizna
  when command.start_with?('add station')
    station = global[:stations][parsed_command[2].capitalize]
    route   = parsed_command[4].split('-').map(&:capitalize).join('-')

    global[:routes][route].add_stations([station])

  # Remove station Sonechko from Myrna-Zalizna
  when command.start_with?('remove station')
    station = global[:stations][parsed_command[2].capitalize]
    route   = parsed_command[4].split('-').map(&:capitalize).join('-')

    global[:routes][route].remove_station(station)

  # Set route Myrna-Zalizna to train R334
  when command.start_with?('set route')
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
