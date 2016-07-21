# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capypage/version'

Gem::Specification.new do |spec|
  spec.name          = 'capypage'
  spec.version       = Capypage::VERSION
  spec.authors       = ['Selvakumar Natesan', 'Simonroy', 'Arvind']
  spec.email         = %w(k.n.selvakumar@gmail.com)
  spec.description   = 'Page Object Model for Capybara'
  spec.summary       = 'Page Object Model for Capybara'
  spec.homepage      = 'http://github.com/TWChennai/capypage'
  spec.license       = 'MIT'
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'capybara', '~> 2.7.0'
  spec.add_dependency 'activesupport', '>= 4.0.0'

  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'sinatra'
end
