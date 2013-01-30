# encoding: utf-8

require_relative '../spec_helper'

describe "Laureate" do
  subject { Nobel::Laureate }

  let(:nelly) {
    subject.new(parsed_fixture(:laureate)["laureates"][2])
  }

  describe "find" do
    it "finds a laureate based on id" do
      with_data([parsed_fixture(:laureate)["laureates"][1]]) do
        l = subject.find(453)

        last_params.must_equal id: 453

        l.name.must_equal 'Christiane Nüsslein-Volhard'
      end
    end
  end

  describe "all" do
    it "returns all laureates per default" do
      with_data(parsed_fixture(:laureate)["laureates"]) do
        laureates = subject.all
        laureates.size.must_equal 3

        last_params.must_equal({})

        laureates[2].name.must_equal 'Nelly Sachs'
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
      nelly.instance_eval do
        id.must_equal 640

        firstname.must_equal "Nelly"
        surname.must_equal "Sachs"

        share.must_equal nil
        motivation.must_equal nil

        born.year.must_equal 1891
        born_city.must_equal "Berlin"
        born_country.must_equal "Germany"
        born_country_code.must_equal "DE"

        died.year.must_equal 1970
        died_city.must_equal "Stockholm"
        died_country.must_equal "Sweden"
        died_country_code.must_equal "SE"
      end
    end
  end

  describe "reload!" do
    it "reloads the data" do
      with_data([parsed_fixture(:laureate)["laureates"][2]]) do
        subject.new('id' => 640).instance_eval do
          name.must_equal ''
          reload!
          name.must_equal 'Nelly Sachs'
        end

        last_params.must_equal({ id: 640 })
      end
    end
  end

  describe "name" do
    it "returns the firstname and surname" do
      nelly.name.must_equal "Nelly Sachs"
    end
  end

  describe "prizes" do
    it "returns an Array of Prize objects" do
      nelly.prizes.first.year.must_equal 1966
    end
  end

  describe "categories" do
    it "returns a list of categories won" do
      nelly.categories.must_equal(["literature"])
    end
  end

  describe "years" do
    it "returns a list of years won" do
      nelly.years.must_equal([1966])
    end
  end
end
