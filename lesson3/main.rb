# frozen_string_literal: true

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
require_relative 'modules/main_methods'

require_relative 'route'
require_relative 'station'

require_relative 'cargo_train'
require_relative 'passenger_train'

require_relative 'cargo_coach'
require_relative 'passenger_coach'

global = {
  stations: [],
  trains:   [],
  routes:   [],
  coaches:  []
}

loop do
  puts 'Please enter command code (1-11):'
  puts ' 1. Create station'
  puts ' 2. Create train'
  puts ' 3. Create route'
  puts ' 4. Add station to route'
  puts ' 5. Remove station'
  puts ' 6. Set route'
  puts ' 7. Add coach'
  puts ' 8. Remove coach from train'
  puts ' 9. Move train'
  puts '10. Occupy coach space'
  puts '11. List stations and trains on station'
  puts "12. Exit from program\n\n"

  command = gets.chomp.to_i

  case command
  when 1 # create station
    create_station(global)
  when 2 # Create train
    create_train(global)
  when 3 # Create route with start and end stations.
    create_route(global)
  when 4 # Add station to route
    add_station_to_route(global)
  when 5 # Remove station from route
    remove_station_from_route(global)
  when 6 # Set route to train
    set_route_to_train(global)
  when 7 # Add coach to train
    add_coach_to_train(global)
  when 8 # Train R334 should leave coach
    train_leave_coach(global)
  when 9 # Train R334 should go to next station
    # Train R334 should go to previous station
    train_went_station(global)
  when 10 # Occupy coach space
    occupy_coach_space(global)
  when 11 # List stations and trains on station
    list_stations(global)
  when 12 # Stop
    stop_executing(global)
  else
    unknown_command(global)
  end
end
