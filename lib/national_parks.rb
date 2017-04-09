# environment file

require "open-uri"
require "nokogiri"
require "pry"
require "require_all"

require_relative "./national_parks/version"
require_relative "./national_parks/cli"
require_relative "./national_parks/scraper"
require_relative "./national_parks/state"
require_relative "./national_parks/park"