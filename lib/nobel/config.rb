# encoding: utf-8

module Nobel
  class Config
    attr_accessor :api_host, :api_version,
                  :json_parser, :http_client, :debug

    def initialize
      @api_host    = 'api.nobelprize.org'
      @api_version = 'v1'
      @json_parser = ->(d) { JSON.parse(d) }
      @http_client = Net::HTTP
      @debug       = false

      yield self if block_given?
    end

    def base_url
      "http://#{api_host}/#{api_version}"
    end

    def debug?
      debug
    end
  end
end
