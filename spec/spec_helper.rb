require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'oanda_ruby_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('{OANDA_API_KEY}') do |interaction|
    ENV['OANDA_RUBY_CLIENT_API_KEY']
  end
end