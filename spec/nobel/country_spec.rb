# encoding: utf-8

require_relative '../spec_helper'

describe "Country" do
  subject { Nobel::Country }

  describe "all" do
    it "returns all the known countries" do
      with_fixture :country do
        subject.all.tap do |a|
          a.size.must_equal 6
          a.last.code.must_equal 'CZ'
        end
      end
    end
  end

  describe "find" do
    it "retrieves based on the code per default" do
      with_fixture :country do
        subject.find(:mg).name.must_equal 'Madagascar'
      end
    end

    it "can also find based on the name" do
      with_fixture :country do
        subject.find('Tuscany (now Italy)', :name).code.must_equal 'IT'
      end
    end
  end

  describe "data" do
    it "retrieves the country data" do
      with_fixture :country do
        subject.data.must_equal country_data
      end
    end
  end

  describe "reload!" do
    it "reloads the data" do
      with_fixture :country do
        subject.instance_eval do
          data.must_equal country_data

          @data = []
          data.must_equal []

          reload!

          data.must_equal country_data
        end
      end
    end
  end
end
