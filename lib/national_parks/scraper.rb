class NationalParks::Scraper

  BASE_PATH = "https://www.nps.gov"
  @@state_names = []

  def self.scrape_find_park_page # class method instantiates new state objects with parameter of hash of state attributes (:name, :url) scraped from NPS website
    find_park_page ||= Nokogiri::HTML(open("https://www.nps.gov/findapark/index.htm"))
    find_park_page.css("map#Map area").each do |state|
      # condition to prevent instantiation of new state object if that state was already created (state is listed more than once in scraped data)
      if !@@state_names.include?(state.attr("alt"))
        @@state_names << state.attr("alt")
        
        state_attributes_hash = {name: state.attr("alt"), url: BASE_PATH + state.attr("href")}
        NationalParks::State.new(state_attributes_hash)
      end
    end
  end

  def self.scrape_state_page(state) # class method adds new park objects to existing state object after instantiating new park objects with parameter of hash of park attributes (:type, :name, :location, :description, :more_info_url) scraped from NPS website
    state_page ||= Nokogiri::HTML(open(state.url))
    state_page.css("div.list_left").each do |park|
      park_attributes_hash = {}
      park_attributes_hash[:type] = park.css("h2").text.strip if park.css("h2").text.match(/\S/) # conditional modifier to account for some park listings not including :type attribute
      park_attributes_hash[:name] = park.css("a").text.strip
      park_attributes_hash[:location] = park.css("h4").text.strip.gsub(/\s{2,}/, " ") if park.css("h4").text.match(/\S/) # conditional modifier to account for some park listings not including :location attribute; #gsub required to clean up formatting in source code
      park_attributes_hash[:description] = park.css("p").text.strip
      park_attributes_hash[:more_info_url] = BASE_PATH + park.css("a").attr("href")

      park = NationalParks::Park.new(park_attributes_hash)
      state.add_park(park)		
    end
  end

end
