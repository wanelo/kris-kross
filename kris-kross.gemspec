# -*- encoding: utf-8 -*-
require File.expand_path('../lib/kris-kross/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eric Saxby"]
  gem.email         = ["sax@wanelo.com"]
  gem.description   = %q{Kris Kross will make you jump jump between domains with cross origin requests}
  gem.summary       = %q{Cross origin requests made easy}
  gem.homepage      = "https://github.com/wanelo/kris-kross"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "kris-kross"
  gem.require_paths = ["lib"]
  gem.version       = Kris::Kross::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-fsevent'
end
