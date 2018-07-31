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
    trains:   [],
    routes:   {},
    coaches:  []
}

until false do
  puts "What to do?"
  command = gets.chomp.downcase
  parsed_command = command.split ' '

  case
    # Create station Myrna
  when command.start_with?('create station')
    name = parsed_command[2].capitalize

    global[:stations][name] = Station.new(name)
    break
    # Create cargo train R334
  when parsed_command[0] == 'create' &&
      parsed_command[2] == 'train'

    name = parsed_command[3]
    type = parsed_command[1]

    global[:trains].push Train.new(name, type)
    break
    # Create route with Myrna and Zalizna
  when command.start_with?('create route with')
    first_station = parsed_command[3].capitalize
    last_station = parsed_command[5].capitalize

    name = first_station + '-' + last_station

    global[:routes][name] = Route.new(
        global[:stations][first_station],
        global[:stations][last_station]
    )
    break
    # Add station Sonechko to Myrna-Zaliznychna
  when command.start_with?('add station')
    station = parsed_command[2].capitalize
    route = parsed_command[4].split('-').map(&:capitalize).join('-')

    global[:routes][route].add_stations([station])
    break
    # Remove station Sonechko from Myrna-Zaliznychna
  when command.start_with?('remove station')
    station = global[:station][parsed_command[2].capitalize]
    route = parsed_command[4].split('-').map(&:capitalize).join('-')

    global[:routes][route].remove_station(station)
    break
    # Set route Myrna-Zaliznychna to train R334
  when command.start_with?('set route')
    train = parsed_command.last
    route = global[:routes][parsed_command[2].split('-').map(&:capitalize).join('-')]

    global[:trains][train].set_route(route)

    break
    # Add coach to train R334
  when command.start_with?('add coach to train')
    train = global[:trains][parsed_command[4]]
    coach = Coach.new(train.type)

    global[:coaches].push coaches

    train.add_coach(coach)
    break

    # Train R334 should leave coach
  when command.end_with?('should leave coach')
    train = global[:trains][parsed_command[1]]

    train.leave_coach
    break
    # Train R334 should go to next station
  when command.end_with?('should go to next station')
    train = global[:trains][parsed_command[1]]

    train.go_to_next_station
    break
    # Train R334 should go to previous station
  when command.end_with?('should go to previous station')
    train = global[:trains][parsed_command[1]]

    train.go_to_previous_station
  end

  break if command == 'stop'
end
