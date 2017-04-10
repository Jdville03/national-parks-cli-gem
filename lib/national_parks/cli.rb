class NationalParks::CLI
	
  def call
    puts "Welcome to National Parks"
    list_states
    list_parks
  end

  def list_states
  	NationalParks::Scraper.scrape_find_park_page
  	NationalParks::State.all.each.with_index(1) do |state, index|
  		puts "#{index}. #{state.name}"
  	end
  end

  def list_parks
  	state_input = gets.strip
  	system("clear")
  	state = NationalParks::State.find_state(state_input)
  	NationalParks::Scraper.scrape_state_page(state)
  	state.parks.each.with_index(1) do |park, index|
  		puts "\n-------------------------------------"
  		puts "#{index}. #{park.name}"
  		puts ""
  		puts "Type:         #{park.type}" if park.type
  		puts "Location:     #{park.location}" if park.location
  		puts "Description:  #{park.description}"
  	end
  	puts "\nIf you would like to see more information for a park, enter the number of the park:"
		park_input = gets.strip
		system("open #{state.find_park(park_input).more_info_url}")
  end

end
