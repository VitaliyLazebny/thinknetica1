require_relative 'validation'

class Train
  include Validation

  attr_accessor :number, :label

  validate :number, :presence
  validate :number, :type, Integer
  validate :label,  :format, /^[A-Z]+$/

end

t = Train.new
t.number = 224
t.label  = 'ADIdDAS'
puts t.valide?
