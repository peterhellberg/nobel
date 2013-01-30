# Nobel

A small API client for the Nobel Prize API.

You can find out more on the official [Developer Zone](http://www.nobelprize.org/nobel_organizations/nobelmedia/nobelprize_org/developer/)

There is also an API Console on [API HQ](http://console.apihq.com/nobel-prize-api)

## Dependencies

Nope.

## Installation

Add this line to your application's Gemfile:

    gem 'nobel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nobel

## Usage

It is probably a good idea to take a look in `specs`

### Prize

```ruby
# All Nobel Prizes in 2010
Nobel::Prize.all year: 2010

# All Peace Prizes 
Nobel::Prize.all category: 'peace'
```

### Laureate

The laureate data contains their prizes (and affiliations)

```ruby
# Find a Nobel Laureate by ID
nelly = Nobel::Laureate.find 640

# Show the categories Nelly won
nelly.categories #=> ["literature"]

# Show the years Nelly won
nelly.years #=> [1966]

# Find all living female Nobel Laureates
#  (`query` is an alias to `all`)
Nobel::Laureate.query diedDate: '0000', gender: 'female'
```

### Country

The country data only contains the country code and name.

```ruby
# To return a list of all known countries
Nobel::Country.all

# To find a specific country
Nobel::Country.find 'FR' #=> #<Nobel::Country:0x007fda82b78220 @code="FR", @name="France">

# You can also find by name
Nobel::Country.find 'Germany', :name #=> #<Nobel::Country:0x007fda82b90b40 @code="DE", @name="Germany">
```

### Configuration

Nothing needs to be configured out of the box, but you can change the
`api_host`, `api_version`, `json_parser`, `http_client` and `debug`
settings like this:

```ruby
Nobel.configure do |c|
  c.api_host    = 'nobel.api'
  c.api_version = 'v42'
  c.json_parser = ->(json) { Oj.load(json) }
  c.http_client = MyOwnHttpClient
  c.debug       = true
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
