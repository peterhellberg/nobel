# encoding: utf-8

require "minitest/autorun"
require "minitest/pride"

require_relative "../lib/nobel"

class BounceURI
  def self.get(uri)
    uri
  end
end

Nobel.configure do |c|
  c.http_client = BounceURI
end

$loaded_fixtures = {}

def fixture(name)
  $loaded_fixtures[name] ||= IO.read("spec/fixtures/#{name}.json")
end

def parsed_fixture(name)
  JSON.parse fixture(name)
end

def with_fixture(name, &block)
  Nobel.api.stub(:get_json, parsed_fixture(name), &block)
end

def with_data(data, &block)
  @last_params = nil
  subject.stub :get_data, ->(params){ @last_params = params; data }, &block
end

def last_params
  @last_params
end

def country_data
  parsed_fixture(:country)['countries']
end
