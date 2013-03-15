# encoding: utf-8

require 'net/http'

module Nobel
  class HTTP
    class << self
      def get(uri)
        Net::HTTP.start(uri.host, uri.port) do |http|
          http.read_timeout = 60

          request  = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)

          http.finish

          response.body if response.code == '200'
        end
      rescue StandardError
        nil
      end
    end
  end
end
