class NationalParks::Scraper

	BASE_PATH = "https://www.nps.gov"

	def self.scrape_find_park_page # class method returns array of hashes of state names and urls
		find_park_page ||= Nokogiri::HTML(open("https://www.nps.gov/findapark/index.htm"))
		states = []
		find_park_page.css("map#Map area").each do |area|
			states << {name: area.attr("alt"), url: BASE_PATH + area.attr("href")}
		end
		states
	end

end