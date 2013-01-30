# encoding: utf-8

describe "Nobel" do
  subject { Nobel }

  describe "configure" do
    it "can be configured" do
      subject.config.api_version.must_equal 'v1'

      subject.configure do |c|
        c.api_version = 'v2'
      end

      subject.config.api_version.must_equal 'v2'
    end

    it "can change the json parser lamda" do
      subject.configure do |c|
        c.json_parser = ->{ 'foo' }
      end

      subject.config.json_parser.call.must_equal 'foo'
    end
  end

  describe "config" do
    it "returns a (default) config object" do
      subject.config.must_be_instance_of Nobel::Config
    end
  end

  describe "api" do
    it "returns a (default) api object" do
      subject.api.must_be_instance_of Nobel::Api
    end
  end
end
