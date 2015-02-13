require 'httparty'
require 'ostruct'

module OandaRubyClient

  class ExchangeRatesClient
    
    # @param api_key [String] The API key for the Excange Rates API.
    # @param use_ssl [Boolean] If +true+, sets the URL endpoint scheme to +https+. If
    #                +false+, sets the scheme to +http+.
    def initialize(api_key = ENV['OANDA_RUBY_CLIENT_API_KEY'], use_ssl = true)
      @api_key, @use_ssl = api_key, use_ssl
    end
    
    # @return [Hash<String, String>] a hash of the supported currency codes to their descriptions
    def currencies
      currencies_response = HTTParty.get("#{oanda_endpoint}#{CURRENCIES_PATH}", headers: oanda_headers)
      handle_response(currencies_response.response)
      result = {}
      currencies_response.parsed_response['currencies'].each do |currency|
        result[currency['code']] = currency['description']
      end
      result
    end
    
    # Returns the exchanges rates based on the specified request
    #
    # @param rates_request [OandaRubyClient::RatesRequest] Request criteria
    # @return [OpenStruct] An object structured similarly to the response from the Exchange Rate API
    def rates(rates_request)
      rates_uri = "#{oanda_endpoint}#{RATES_BASE_PATH}#{rates_request.base_currency}.json?#{rates_request.query_string}"
      rates_response = HTTParty.get(rates_uri, headers: oanda_headers)
      handle_response(rates_response.response)
      OpenStruct.new(rates_response.parsed_response)
    end
    
    # Returns the number of remaining quote requests
    #
    # @return [Fixnum, 'unlimited'] Number of remaining quote requests
    def remaining_quotes
      remaining_quotes_response = HTTParty.get("#{oanda_endpoint}#{REMAINING_QUOTES_PATH}", headers: oanda_headers)
      handle_response(remaining_quotes_response.response)
      remaining_quotes_response.parsed_response['remaining_quotes']
    end
    
  private
    
    OANDA_ENDPOINT = '//www.oanda.com/rates/api/v1/' #:nodoc:

    RATES_BASE_PATH = 'rates/' #:nodoc:
    CURRENCIES_PATH = 'currencies.json' #:nodoc:
    REMAINING_QUOTES_PATH = 'remaining_quotes.json' #:nodoc:

    attr_accessor :api_key, :use_ssl
    
    def handle_response(response)
      if response.code_type != Net::HTTPOK
        if response.body
          raise JSON.parse(response.body)['message']
        else 
          raise response
        end
      end
    end

    def oanda_headers
      { 'Authorization' => "Bearer #{@api_key}"}
    end
    
    def oanda_endpoint
      "#{scheme}#{OANDA_ENDPOINT}"
    end
    
    def scheme
      @use_ssl ? 'https:' : 'http:'
    end
        
  end
  
end