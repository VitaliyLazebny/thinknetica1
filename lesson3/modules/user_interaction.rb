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

def display_trains(global)
  puts 'Trains list:'
  global[:trains].each_with_index do |train, index|
    puts "#{index}. #{train.name}"
  end
end

def ask_train_id(global)
  puts 'Please enter train number:'
  train = gets.chomp.to_i

  if train.negative? || train > global[:trains].size - 1
    raise "Route #{train} doesn't exist."
  end

  train
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

def ask_station(question, global)
  puts question
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

def display_routes(global)
  puts 'Routes list:'
  global[:routes].each_with_index do |route, index|
    puts "#{index}. #{route.name}"
  end
end

def ask_route_id(global)
  puts 'Please enter route number:'
  route = gets.chomp.to_i

  if route.negative? || route > global[:routes].size - 1
    raise "Route #{route} doesn't exist."
  end

  route
end

def create_coach(train, global)
  if train.type == 'cargo'
    puts 'Please enter volume amount:'
    volume = gets.chomp

    raise 'Volume should be Integer.' unless volume.to_i.to_s == volume

    unless volume.to_i.positive?
      raise 'Volume should be larger then zero.'
    end

    volume = volume.to_i
    coach  = CargoCoach.new(volume)
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
    coach  = PassengerCoach.new(places)
  end

  global[:coaches].push coach
  train.add_coach       coach

  coach
end

def get_direction(_global)
  puts 'Directions:'
  puts '1. Next station'
  puts '2. previous station'
  puts 'Please enter direction number:'
  direction = gets.chomp.to_i
  raise 'Direction not applicable.' unless [1, 2].include?(direction)

  direction
end

def get_coach_id(train, _global)
  puts 'Please select the coach:'
  coach_number = gets.chomp.to_i

  if coach_number.negative? || coach_number > train.size - 1
    raise 'Invalid coach selected.'
  end

  coach_number
end
