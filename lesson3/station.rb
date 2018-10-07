# frozen_string_literal: true

# class Station
require_relative 'modules/instance_counter'
require_relative '../lesson10/validation'

# Station
class Station
  include InstanceCounter
  include Validation

  attr_reader :name
  attr_reader :trains

  alias id name

  validate :name, :type,   String
  validate :name, :format, /^[A-Za-z]{0,3}$/
  validate :name, :custom do |n|
    raise 'Station with given name already exist.' if self.class.find(n)
  end

  def initialize(name)
    @name = name
    @trains = []

    validate!

    register_instance
  end

  # -   -   -   -   -   -   -   -   -   -

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
