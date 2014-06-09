# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inews_client/version'

Gem::Specification.new do |gem|
  gem.name          = "inews_client"
  gem.version       = InewsClient::VERSION
  gem.authors       = ["Gilad Barzilay"]
  gem.email         = ["gilbar11@gmail.com"]
  gem.description   = %q{ This service works as a daemon that watches an iNEWS rundown while the show is
on air. You can get information about a story, and if it got fired already }
  gem.summary       = %q{ Ruby client for iNEWS Web Services API }
  gem.homepage      = "https://github.com/gilbar11/iNews-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.add_dependency 'savon', '~> 2.3.0'
  gem.add_dependency 'xpath'
  gem.add_dependency 'sax-machine'
  gem.add_dependency 'libxml-ruby'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'pry'
end
