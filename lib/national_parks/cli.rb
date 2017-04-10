class NationalParks::CLI
	
  def call
    puts "Welcome to National Parks"
    list_states
  end

  def list_states
  	states_array = NationalParks::Scraper.scrape_find_park_page
  	NationalParks::State.create_from_collection(states_array)
  end

end
