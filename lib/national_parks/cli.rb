class NationalParks::CLI
	
  def initialize
  	welcome
  	NationalParks::Scraper.scrape_find_park_page
  end

  def call
    list_states
    state_selection
    list_parks
    menu
  end

  def welcome
		puts " -----------------------------------------"
  	puts "|                                         |"
    puts "|        Welcome to National Parks        |"
    puts "|                                         |"
    puts " -----------------------------------------"
  end

  def list_states
  	puts "\nFind information about the national parks located in any of the U.S. states or territories:"
  	puts ""
  	NationalParks::State.all.each.with_index(1) do |state, index|
  		puts "#{index}. #{state.name}"
  	end
  end

  def state_selection
  	puts "\nSelect a state or territory by number or name:"
  	state_input = gets.strip
  	if state_input.to_i.between?(1, NationalParks::State.all.length)
  		@state = NationalParks::State.find_state(state_input)
  	elsif NationalParks::State.find_state_by_name(state_input)
  		@state = NationalParks::State.find_state_by_name(state_input)
  	else
  		puts "Invalid entry."
  		state_selection
  	end
  end

  def list_parks
  	NationalParks::Scraper.scrape_state_page(@state) if @state.parks.empty? # conditional modifier to prevent redundant scraping and instantiation of state's park objects if that state was previously selected by the user
  	system("clear")
  	sleep(0.25)
  	puts "\nNational Parks in #{@state.name}:"
  	@state.parks.each.with_index(1) do |park, index|
  		puts "\n-----------------------------------------"
  		puts "#{index}. #{park.name}"
  		puts ""
  		puts "Type:         #{park.type}" if park.type
  		puts "Location:     #{park.location}" if park.location
  		puts "Description:  #{park.description}"
  		sleep(0.25)
  	end
  end

  def menu
  	input = ""
  	while input.downcase != "exit"
  		puts "\nTo see more information in your web browser for a national park in #{@state.name}, enter the number of the park.\nType \"list\" to see the states and territories again or type \"exit\"."
			input = gets.strip
			if input.to_i.between?(1, @state.parks.length)
				system("open #{@state.find_park(input).more_info_url}")
			elsif input.downcase == "list"
				call
			elsif input.downcase == "exit"
				puts "\nGet out and enjoy the national parks! Goodbye!"
			else
				puts "\nInvalid entry."
			end	
		end
  end

end
