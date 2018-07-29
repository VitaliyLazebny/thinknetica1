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
require 'route'
require 'station'

require 'cargo_train'
require 'passenger_train'

require 'cargo_coach'
require 'passenger_coach'

# Commands should not be hardcoded.

global = []

while true do
  puts "What to do?"
  command        = gets.chomp.downcase
  parsed_command = command.split ' '


  end
end
