class NationalParks::Park

  attr_accessor :state, :type, :name, :location, :description, :more_info_url

  def initialize(attribute_hash = nil)
    if attribute_hash
      attribute_hash.each{|key, value| self.send("#{key}=", value)}
    end
  end

  # optionality to add more park attributes if desired
	
  #def add_park_attributes(attributes_hash)
  #  attributes_hash.each{|key, value| self.send("#{key}=", value)}
  #  self
  #end

end
