# encoding: utf-8

require_relative '../spec_helper'

describe "Api" do
  subject { Nobel::Api.new(config) }

  let(:config) {
    Nobel::Config.new.tap do |c|
      c.api_host    = api_host
      c.api_version = api_version
      c.http_client = BounceURI
    end
  }

  let(:api_host)    { 'api.test' }
  let(:api_version) { '42'       }

  describe "get" do
    it "should print debugging info if @config.debug?" do
      ->{
        subject.config.debug = true
        subject.get('foo') }.must_output "GET: http://api.test/42/foo?\n"
    end
  end

  describe "country" do
    it "parses the country.json" do
      subject.stub(:http_get, fixture(:country)) do
        subject.country['countries'].first['name'].must_equal 'Germany (now Russia)'
      end
    end
  end

  describe "get_json" do
    it "returns parsed json" do
      subject.stub(:http_get, fixture(:country)) do
        subject.get_json(:country)['countries'][2]['code'].must_equal 'LT'
      end
    end
  end
end
