# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'isbnify/version'

Gem::Specification.new do |spec|
  spec.name          = "isbnify"
  spec.version       = Isbnify::VERSION
  spec.authors       = ["cseydel"]
  spec.email         = ["christoph.seydel@me.com"]
  spec.description   = %q{This gem verifies, creates and hyphinates ISBN13 numbers}
  spec.summary       = %q{This gem verifies, creates and hyphinates ISBN13 numbers}
  spec.homepage      = "https://github.com/cseydel/isbnify"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", ">= 1.2.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "fakeweb", "~> 1.3.0"
  spec.add_development_dependency "vcr", "~> 2.6.0"
  spec.add_development_dependency "simplecov", "~> 0.7.1"
  spec.add_development_dependency "simplecov-gem-adapter", "~> 1.0.1"
end
