require 'spec_helper'
require 'date'

describe OandaRubyClient do
  
  it 'has a version number' do
    expect(OandaRubyClient::VERSION).not_to be nil
  end

  it 'retrieves the USD to GBP bid exchange rate for February 11, 2015' do
    VCR.use_cassette('oanda/rates') do |cassette|
      client = OandaRubyClient::ExchangeRatesClient.new
      fx_date = Date.new(2015, 2, 11)
      rates_request = OandaRubyClient::RatesRequest.new('USD', quote: [ 'GBP' ], date: fx_date)
      result = client.rates(rates_request)
      expect(result.base_currency).to eq('USD')
      expect(result.meta['effective_params']['date']).to eq(fx_date.iso8601)
      expect(result.quotes['GBP']['bid']).to eq('0.65533')
    end
  end
  
  it 'retrieves the list of supported currencies' do
    VCR.use_cassette('oanda/currencies') do |cassette|
      client = OandaRubyClient::ExchangeRatesClient.new
      result = client.currencies
      expect(result['USD']).to eq('US Dollar')
    end
  end
  
  it 'retrieves the remaining quotes' do
    VCR.use_cassette('oanda/remaining_quotes') do |cassette|
      client = OandaRubyClient::ExchangeRatesClient.new
      result = client.remaining_quotes
      expect(result.is_a?(Numeric) || result == 'unlimited').to be true
    end
  end
  
  it 'returns an error if the api key is missing' do
    VCR.use_cassette('oanda/missing_api_key') do |cassette|
      client = OandaRubyClient::ExchangeRatesClient.new(nil)
      expect { client.remaining_quotes }.to raise_error
    end
  end
  
end
