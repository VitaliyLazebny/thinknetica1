require_relative 'accessors'

class Body
  extend Accessors

  attr_accessor_with_history [:hand_size]
end

child           = Body.new
child.hand_size = 1
child.hand_size = 2
child.hand_size = 3
child.hand_size = 1

puts child.hand_size
puts '-----------------'
puts child.hand_size_history
