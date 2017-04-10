class InvalidType < StandardError; end

class NationalParks::State
  
  attr_accessor :name, :url

  @@states = []

  # instance methods
  def initialize(attribute_hash = nil)
    if attribute_hash
      attribute_hash.each{|key, value| self.send("#{key}=", value)}
    end
    @parks = [] # has_many park objects interface
    @@states << self
  end

  def parks # has_many park objects interface
    @parks.dup.freeze.sort_by{|park| park.name} # park objects of each state object stored in alphabetical order by name
  end

  def add_park(park) # has_many park objects interface
    if !park.is_a?(NationalParks::Park)
      raise InvalidType, "#{park.class} received, Park expected"
    else
      @parks << park unless @parks.include?(park)
      park.state << self unless park.state.include?(self) # state attribute for each park object is an array of state objects to accomodate a park object belonging to multiple states
    end
  end

  def find_park_by_name(name)
    parks.detect{|park| park.name == name}
  end

  def find_park(id)
    parks[id.to_i - 1]
  end

  #class methods
  def self.all
    @@states.sort_by{|state| state.name} # state objects stored in alphabetical order by name
  end

  def self.create_from_collection(states_array) # parameter is array of hashes of state attributes
    states_array.each{|state_hash| self.new(state_hash)}
    #self.new(name).tap{|state| state.save}
  end

  def self.find_state_by_name(name)
    self.all.detect{|state| state.name == name}
  end

  def self.find_state(id)
    self.all[id.to_i - 1]
  end
  
end