class NationalParks::Scraper

	BASE_PATH = "https://www.nps.gov"

	def self.scrape_find_park_page # class method instantiates new state objects with parameter of hash of state attributes (:name, :url) scraped from NPS website
		find_park_page ||= Nokogiri::HTML(open("https://www.nps.gov/findapark/index.htm"))
		find_park_page.css("map#Map area").each do |area|
			state_attributes_hash = {name: area.attr("alt"), url: BASE_PATH + area.attr("href")}
			NationalParks::State.new(state_attributes_hash)
		end
	end

	def self.scrape_state_page(url) # class method returns hash of park attributes (:type, :name, :location, :description, :more_info_url)
		state_page ||= Nokogiri::HTML(open(url))
		park_hash = {}
		state_page.css("div.list_left").each do |park|
			park_hash[:type] = park.css("h2").text if park.css("h2").text.match(/\S/) # conditional statement to account for some park listings not including :type attribute
			park_hash[:name] = park.css("a").text
			park_hash[:location] = park.css("h4").text if park.css("h4").text.match(/\S/) # conditional statement to account for some park listings not including :location attribute
			park_hash[:description] = park.css("p").text.strip
			park_hash[:more_info_url] = BASE_PATH + park.css("a").attr("href")
		end
	end

end