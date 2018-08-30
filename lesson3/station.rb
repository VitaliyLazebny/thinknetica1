# frozen_string_literal: true

# class Station
require_relative 'modules/instance_counter'

# Station
class Station
  include InstanceCounter

  attr_reader :name
  attr_reader :trains

  alias id name

  def initialize(name)
    @name = name
    @trains = []

    validate!

    register_instance
  end

  # -   -   -   -   -   -   -   -   -   -
  # Validation methods
  def valid?
    validate!
  rescue StandardError
    false
  else
    true
  end

  def validate!
    # Name should be String longer then 3 symbols.
    if !@name.is_a?(String) || @name.size < 3
      raise 'Name should be String longer then 3 symbols.'
    end

    # Station with given name already exist
    raise 'Station with given name already exist.' if self.class.find(@name)
  end
  # -   -   -   -   -   -   -   -   -

  def accept_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def to_s
    res  = "Station '#{name}'"
    res += " with trains: #{trains.map(&:to_s).join(', ')}" unless trains.empty?

    res
  end

  # Iteration
  def each_train
    @trains.each do |train|
      yield(train)
    end
  end

  def each_train_with_index
    @trains.each_with_index do |index, train|
      yield(index, train)
    end
  end
end
