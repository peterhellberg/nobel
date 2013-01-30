# encoding: utf-8

module Nobel
  class Affiliation
    attr_reader :name, :country, :city

    def initialize(data = nil)
      data ||= {}

      data.tap do |d|
        @name    = d['name']
        @country = d['country']
        @city    = d['city']
      end
    end
  end
end
