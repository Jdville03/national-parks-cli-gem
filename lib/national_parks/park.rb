class NationalParks::Park

  attr_accessor :type, :name, :location, :description, :more_info_url
  attr_reader :state # belongs to state object interface

  def initialize(attribute_hash = nil)
    if attribute_hash
      attribute_hash.each{|key, value| self.send("#{key}=", value)}
    end
    @state = [] # state attribute for each park object is an array of state objects to accomodate a park object belonging to multiple states
  end

end
