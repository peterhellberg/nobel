# encoding: utf-8

require_relative '../spec_helper'

describe "Prize" do
  subject { Nobel::Prize }

  let(:peace_2012) {
    subject.new(parsed_fixture(:peace_prize)["prizes"][0])
  }

  describe "all" do
    it "returns all prizes per default" do
      with_data(parsed_fixture(:peace_prize)["prizes"]) do
        prizes = subject.query
        prizes.size.must_equal 3

        last_params.must_equal({})

        prizes[2].year.must_equal 2010
      end
    end

    it "queries using a params hash" do
      with_data([]) do
        params = { bornDate: 1960 }
        subject.query(params)
        last_params.must_equal params

        params = { diedCity: 'Stockholm' }
        subject.query(params)
        last_params.must_equal params
      end
    end
  end

  describe "initialize" do
    it "populates the accessors" do
      peace_2012.instance_eval do
        year.must_equal 2012
        category.must_equal "peace"
        share.must_equal nil
        motivation.must_equal nil
      end
    end
  end
end
