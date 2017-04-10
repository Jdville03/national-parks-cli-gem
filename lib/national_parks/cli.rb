class NationalParks::CLI
	
  def call
  	welcome
    list_states
    state_selection
    list_parks
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
  	NationalParks::Scraper.scrape_find_park_page
  	NationalParks::State.all.each.with_index(1) do |state, index|
  		puts "#{index}. #{state.name}"
  	end
  end

  def state_selection
  	puts "\nSelect a state or territory by number or name:"
  	state_input = gets.strip
  	if state_input.to_i.between?(1..NationalParks::State.all.length)
  		state = NationalParks::State.find_state(state_input)
  	elsif NationalParks::State.find_state_by_name(state_input)
  		state = NationalParks::State.find_state_by_name(state_input)
  	else
  		puts "Invalid entry."
  		state_selection
  end

  def list_parks
  	system("clear")	
  	NationalParks::Scraper.scrape_state_page(state_selection)
  	state_selection.parks.each.with_index(1) do |park, index|
  		puts "\n-------------------------------------"
  		puts "#{index}. #{park.name}"
  		puts ""
  		puts "Type:         #{park.type}" if park.type
  		puts "Location:     #{park.location}" if park.location
  		puts "Description:  #{park.description}"
  	end
  	
  	input = nil
  	while != "exit"
  		puts "\nIf you would like to see more information for one of these parks in your web browser, enter the number of the park. Type \"list\" to start over and see the states and territories again. Or type \"exit\"."
			park_input = gets.strip
			if park_input.to_i.between?(1..state_selection.parks.length)
				system("open #{state.find_park(park_input).more_info_url}")
			elsif park_input.downcase == "list"
				call
			elsif park_input.downcase == "exit"
				puts "Get out and enjoy the national parks! Goodbye!"
			else
				puts "Invalid entry. Try again."
				park_input = gets.strip
			end	
		end
  end

end
