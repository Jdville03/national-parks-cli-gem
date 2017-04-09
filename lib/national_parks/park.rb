class NationalParks::Park

	attr_accessor :state, :type, :name, :location, :description, :info_url

	@@parks = []

	def initialize(attribute_hash = nil)
		if attribute_hash
			attribute_hash.each{|key, value| self.send("#{key}=", value)}
		end	
	end

end
