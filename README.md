# Oanda Ruby Client

The Oanda Ruby Client provides a simple client class to retrieve exchange rates from Oanda using the Exchange Rate API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oanda_ruby_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oanda_ruby_client

## Usage

### Getting Started

Initialize the client as follows:

```ruby
require 'oanda_ruby_client'

client = OandaRubyClient::ExchangeRatesClient.new('MY_API_KEY') # Provide your API Key as the parameter
```

If you store the API key in an environment variable named `OANDA_RUBY_CLIENT_API_KEY`, you can omit the parameter:

```ruby
client = OandaRubyClient::ExchangeRatesClient.new
```

### Get Rates

Create a request specifying the base currency as the first parameter, and any optional paramters as a hash. The keys of the optional paramters are the same as those for the [Exchange Rate API](http://developer.oanda.com/exchange-rates-api/v1/rates/#input-query-parameters):

For example, to specify a base currency of USD, a quote currency of GBP, and a date of February 11, 2015:

```ruby
rates_request = OandaRubyClient::RatesRequest.new('USD', quote: 'GBP', date: '2015-02-11')
```

Date parameters can be specified using a string in the format of `YYYY-MM-DD` or by using an instance of `Date`:

```ruby
require 'date'

rates_request = OandaRubyClient::RatesRequest.new('USD', quote: 'GBP', date: Date.new(2015, 2, 11))
```

Multi-value parameters (e.g., quote currency) can be specified using arrays:

```ruby
rates_request = OandaRubyClient::RatesRequest.new('USD', quote: [ 'GBP', 'EUR' ], date: '2015-02-11')
```

Pass the rates request as a parameter into the `rates` method of the client:

```ruby
rates_result = client.rates(rates_request)
```

The returning object will be an `OpenStruct` with the attributes `base_currency` (String), `meta` (Hash), `quotes` (Hash).

### Get Currencies

To obtain the collection of supported currencies, use the `currencies` method:

```ruby
currencies_result = client.currencies
```

The returning object will be a hash of currency codes to descriptions.

### Get Remaining Quotes

For plans that have a limited number of quotes, use the `remaining_quotes` method to return the number of remaining quotes:

```ruby
remaining_quotes_result = client.remaining_quotes
```

### Additional Resources

* http://developer.oanda.com/exchange-rates-api/

## Contributing

1. Fork it 
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
