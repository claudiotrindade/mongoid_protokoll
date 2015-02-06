# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_protokoll/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_protokoll"
  spec.version       = MongoidProtokoll::VERSION
  spec.authors       = ["Claudio Trindade"]
  spec.email         = ["claudiotrindade.cc@gmail.com"]
  spec.summary          = "A simple Rails gem to create custom autoincrement Time base values to a database column. Is another version of 'gem protokoll' for mongoid. For more information access the link: https://github.com/celsodantas/protokoll"
  spec.description      = "Rails 4 gem to enable creation of a custom autoincrement Time based string on a model defined by a pattern. ex. 20110001, 20110002, 20110003, 20120001, 20120002..." 
  spec.homepage      = "https://github.com/claudiotrindade/mongoid_protokoll"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
