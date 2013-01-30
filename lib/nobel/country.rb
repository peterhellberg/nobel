# encoding: utf-8

module Nobel
  class Country
    class << self
      def all
        data.map { |c| new(c) }
      end

      def find(value, key = 'code')
        value = key == 'code' ? value.to_s.upcase : value.to_s
        new data.detect { |c| c[key.to_s] == value }
      end

      def data
        @data ||= get_data
      end

      def reload!
        @data = get_data
        self
      end

      private

      def get_data
        Nobel.api.country['countries'] || []
      end
    end

    attr_reader :name, :code

    def initialize(data)
      data ||= { 'code' => 'ZZ', 'name' => 'Unknown' }

      @name = data['name']
      @code = data['code']
    end
  end
end
