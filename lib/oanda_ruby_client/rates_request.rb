require 'date'
require 'addressable/uri'

module OandaRubyClient
  
  class RatesRequest
  
    attr_accessor :base_currency, :query_params
        
    # @param base_currency [String] Currency code for the base currency
    # @param query_params [Hash] Optional query parameters
    def initialize(base_currency, query_params = {})
      @base_currency, @query_params = base_currency.to_s.upcase, query_params
    end
    
    # @return [String] the query string that will be passed to the API
    def query_string
      [ :date, :start, :end ].each do |date_key|
        if query_params[date_key] && query_params[date_key].is_a?(Date)
          query_params[date_key] = query_params[date_key].iso8601
        end
      end
      uri = Addressable::URI.new
      uri.query_values = query_params
      uri.query
    end
    
  end
  
end