# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oanda_ruby_client/version'

Gem::Specification.new do |spec|
  spec.name          = "oanda_ruby_client"
  spec.version       = OandaRubyClient::VERSION
  spec.authors       = ["David Massad"]
  spec.email         = ["david.massad@fronteraconsulting.net"]

  spec.summary       = "Oanda Ruby Client"
  spec.description   = 'Provides a client for the Oanda Exchange Rate API'
  spec.homepage      = "https://github.com/FronteraConsulting/oanda_ruby_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'addressable', '~> 2.3.7'
  
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr', '~> 2.9.3'
  spec.add_development_dependency 'webmock', '~> 1.20.4'
  spec.add_development_dependency 'simplecov', '~> 0.9.1'
  
end
