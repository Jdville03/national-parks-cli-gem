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
    system("clear")
    puts " ----------------------------------------"
    puts "|                                         |"
    puts "|        Welcome to National Parks        |"
    puts "|                                         |"
    puts " ----------------------------------------"
    puts "\nFind information about the national parks located in any of the U.S. states or territories"
  end

  def list_states
    # states/territories displayed in table format with 2 columns
    all_rows = []
    row = []
    NationalParks::State.all.each.with_index(1) do |state, index|
      row = [] if index.odd?
      row << "#{index}. #{state.name}"
      all_rows << row if index.even? || index == NationalParks::State.all.length
    end
    table = Terminal::Table.new :title => "U.S. States and Territories", :rows => all_rows
    puts "\n#{table}"
  end

  def state_selection
    puts "\nSelect a state or territory by " + "number".underline + " or " + "name".underline + ":"
    state_input = gets.strip
    if state_input.to_i.between?(1, NationalParks::State.all.length)
      @state = NationalParks::State.find_state(state_input)
    elsif NationalParks::State.find_state_by_name(state_input)
      @state = NationalParks::State.find_state_by_name(state_input)
    else
      puts "Invalid entry.".colorize(:red)
      state_selection
    end
  end

  def list_parks
    NationalParks::Scraper.scrape_state_page(@state) if @state.parks.empty? # conditional modifier to prevent redundant scraping and instantiation of state's park objects if that state was previously selected by the user
    system("clear")
    puts "\nNational Parks in #{@state.name}:"
    sleep(0.25)
    @state.parks.each.with_index(1) do |park, index|
      puts "\n----------------------------------------------".colorize(:green)
      puts "#{index}. #{park.name}".colorize(:blue)
      puts ""
      puts "Type:         #{park.type}" if park.type
      puts "Location:     #{park.location}" if park.location
      puts "Description:  #{park.description}"
      sleep(0.25)
    end
  end

  def menu
    puts "\nTo see more information in your web browser for a national park in #{@state.name}, enter the " + "number".underline + " of the park.\nType " + "list".underline +  " to see the states and territories again or type " + "exit".underline + "."
    input = gets.strip
    if input.to_i.between?(1, @state.parks.length)
      system("open #{@state.find_park(input).more_info_url}")
      menu
    elsif input.downcase == "list"
      call
    elsif input.downcase == "exit"
      puts "\nGet out and enjoy the national parks! Goodbye!\n".colorize(:green)
    else
      puts "\nInvalid entry.".colorize(:red)
      menu
    end
  end		

end
