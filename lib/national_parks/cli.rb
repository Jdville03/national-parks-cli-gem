class NationalParks::CLI
	
  def call
    puts "Welcome to National Parks"
    list_states
  end

  def list_states
  	NationalParks::Scraper.scrape_find_park_page
  	NationalParks::State.all.each.with_index(1) do |state, index|
  		puts "#{index}. #{state.name}"
  	end
  end

  def list_parks

  end

end
