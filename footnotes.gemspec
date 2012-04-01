# -*- encoding: utf-8 -*-
require File.expand_path('../lib/footnotes/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Roman V. Babenko"]
  gem.email         = ["romanvbabenko@gmail.com"]
  gem.description   = %q{ Rails GUI based debugging }
  gem.summary       = %q{ Flexible Rails GUI based debugging helper }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "footnotes"
  gem.require_paths = ["lib"]
  gem.version       = Footnotes::VERSION

  gem.add_dependency 'rails', '~> 3.0'
  
  gem.add_development_dependency 'rspec', '~> 2.9'
end
