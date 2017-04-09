class InvalidType < StandardError; end

class NationalParks::State
  attr_accessor :name, :url

  @@states = []

  # instance methods
  def initialize(attribute_hash = nil)
    if attribute_hash
      attribute_hash.each{|key, value| self.send("#{key}=", value)}
    end
    @parks = [] # has_many parks interface
    @@states << self
  end

  #def save
  #  self.class.all << self
  #end

  def parks # has_many parks interface
    @parks.dup.freeze
  end

  def add_park(park) # has_many parks interface
    if !park.is_a?(NationalParks::Park)
      raise InvalidType, "#{park.class} received, Park expected"
    else
      @parks << park unless @parks.include?(park)
      #park.state = self unless park.state == self
      park.state << self unless park.state.include?(self)
    end
  end

  #class methods
  def self.all
    @@states.sort_by{|state| state.name} # state objects stored in alphabetical order by name
  end

  def self.create_from_collection(states_array)
    states_array.each{|state_hash| self.new(student_hash)}
    #self.new(name).tap{|state| state.save}
  end

  def self.find_by_name(name)
    self.all.detect{|state| state.name == name}
  end

  #def self.find_or_create_by_name(name)
  #  self.find_by_name(name) || self.create(name)
  #end

  def self.find(id)
    self.all[id - 1]
  end
  
end