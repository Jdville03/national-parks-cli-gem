# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'national_parks/version'

Gem::Specification.new do |spec|
  spec.name          = "national_parks"
  spec.version       = NationalParks::VERSION
  spec.date          = "2017-04-11"
  spec.authors       = ["Jarrel deLottinville"]
  spec.email         = ["jarrel.delottinville@gmail.com"]

  spec.summary       = %q{National parks by U.S. state or territory.}
  spec.description   = %q{List and details of national parks by state or territory as provided by the U.S. National Park Service website.}
  spec.homepage      = "https://github.com/Jdville03/national-parks-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  #spec.bindir        = "exe"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables = ["national_parks"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "require_all"
  spec.add_dependency "nokogiri"
  spec.add_dependency "colorize"
  spec.add_dependency "terminal-table"
end
