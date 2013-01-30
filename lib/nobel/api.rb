# encoding: utf-8

require 'uri'
require 'json'

module Nobel
  class Api
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def prize(params = {})
      get_json :prize, params
    end

    def laureate(params = {})
      get_json :laureate, params
    end

    def country
      get_json :country
    end

    def get_json(endpoint, params = {})
      load_json get("#{endpoint}.json", params) || "{}"
    end

    def get(path, params = {})
      uri = prepared_uri(path, params)

      puts "GET: #{uri}" if @config.debug?

      http_get(uri)
    end

    private

    def http_get(uri)
      @config.http_client.get(uri)
    end

    def load_json(doc)
      @config.json_parser.call(doc)
    end

    def prepared_uri(endpoint, params = {})
      endpoint_uri(endpoint).tap do |uri|
        uri.query = URI.encode_www_form(params)
      end
    end

    def endpoint_uri(endpoint)
      URI.parse("#{@config.base_url}/#{endpoint}")
    end
  end
end
