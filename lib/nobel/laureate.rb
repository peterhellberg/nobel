# encoding: utf-8

require 'date'

module Nobel
  class Laureate
    class << self
      def find(id)
        data = get_data(id: id)
        new(data.first) if data.any?
      end

      def all(params = {})
        get_data(params).map { |c| new(c) }
      end

      alias :query :all

      def get_data(params = {})
        Nobel.api.laureate(params)['laureates'] || []
      end
    end

    attr_reader :data, :id, :firstname, :surname, :share, :motivation,
                :born, :born_city, :born_country, :born_country_code,
                :died, :died_city, :died_country, :died_country_code

    def initialize(data)
      @data = data || {}

      year_regex = /^\d{4}-[0-1][1-9]-\d{2}$/

      @data.tap do |d|
        @id                = Integer(d['id'])

        @firstname         = d['firstname']
        @surname           = d['surname']

        @share             = Integer(d['share'])  if d['share']
        @motivation        = d['motivation']      if d['motivation']

        @born              = Date.parse d['born'] if d['born'] =~ year_regex
        @born_city         = d['bornCity']        if d['bornCity']
        @born_country      = d['bornCountry']     if d['bornCountry']
        @born_country_code = d['bornCountryCode'] if d['bornCountryCode']

        @died              = Date.parse d['died'] if d['died'] =~ year_regex
        @died_city         = d['diedCity']        if d['diedCity']
        @died_country      = d['diedCountry']     if d['diedCountry']
        @died_country_code = d['diedCountryCode'] if d['diedCountryCode']
      end
    end

    def reload!
      initialize self.class.get_data(id: id).first
      self
    end

    def name
      "#{firstname} #{surname}".strip
    end

    def prizes
      @prizes ||= (data['prizes'] || []).map do |p|
        Prize.new(p)
      end
    end

    def categories
      won(:category)
    end

    def years
      won(:year)
    end

    private

    def won(field)
      prizes.map(&field).uniq
    end
  end
end
