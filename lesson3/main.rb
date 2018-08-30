# frozen_string_literal: true

# Text interface to railway facilities
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
  show_commands_list(global)
  command = gets.chomp.to_i

  commands = [
    nil,
    'create_station',
    'create_train',
    'create_route',
    'add_station_to_route',
    'remove_station_from_route',
    'set_route_to_train',
    'add_coach_to_train',
    'train_leave_coach',
    'train_went_station',
    'occupy_coach_space',
    'list_stations',
    'stop_executing',
    'unknown_command'
  ]

  send commands[command], global
end
