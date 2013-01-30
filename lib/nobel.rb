# encoding: utf-8

require "nobel/api"
require "nobel/config"
require "nobel/country"
require "nobel/http"
require "nobel/laureate"
require "nobel/affiliation"
require "nobel/prize"
require "nobel/version"

module Nobel
  class << self
    def configure(&block)
      yield(config)
    end

    def config
      @config ||= Config.new
    end

    def api
      @api ||= Api.new(config)
    end
  end
end
