# encoding: utf-8

module Nobel
  class Prize
    class << self
      def all(params = {})
        get_data(params).map { |c| new(c) }
      end

      alias :query :all

      def get_data(params = {})
        Nobel.api.prize(params)['prizes'] || []
      end
    end

    attr_reader :data, :year, :category, :share, :motivation

    def initialize(data)
      @data = data || {}

      @data.tap do |d|
        @year       = Integer(d['year'])
        @category   = d['category']
        @share      = Integer(d['share']) if d['share']
        @motivation = d['motivation']
      end
    end

    def affiliations
      @affiliations ||= (data['affiliations'] || []).map do |a|
        Affiliation.new(a) if a.respond_to?(:has_key?)
      end.compact
    end

    def laureates
      @laureates ||= (data['laureates'] || []).map do |l|
        Laureate.new(l)
      end
    end
  end
end
