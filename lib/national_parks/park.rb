class NationalParks::Park

  attr_accessor :type, :name, :location, :description, :more_info_url
  attr_reader :state # belongs to state object interface

  def initialize(attribute_hash = nil)
    if attribute_hash
      attribute_hash.each{|key, value| self.send("#{key}=", value)}
    end
  end

  def state=(state) # belongs to state object interface
    if !state.is_a?(NationalParks::State)
      raise InvalidType, "#{state.class} received, State expected"
    else
      @state = state
      state.add_park(self) unless state.parks.include?(self)
    end
  end

end
