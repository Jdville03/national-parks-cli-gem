class InvalidType < StandardError; end

class NationalParks::State
  attr_reader :name

  @@all = []

  # instance methods
  def initialize(name)
    @name = name
    @parks = [] # has_many parks interface
  end

  def save
    self.class.all << self
  end

  def parks # has_many parks interface
    @parks.dup.freeze
  end

  def add_park(park) # has_many parks interface
    if !park.is_a?(NationalParks::Park)
      raise InvalidType, "must be a Park"
    else
      @parks << park unless @parks.include?(park)
      park.state = self unless park.state == self
    end
  end

  #class methods
  def self.all
    @@all.sort # state objects stored in alphabetical order
  end

  def self.create(name)
    self.new(name).tap{|state| state.save}
  end

  def self.find_by_name(name)
    self.all.detect{|state| state.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.find(id)
    self.all[id - 1]
  end
  
end