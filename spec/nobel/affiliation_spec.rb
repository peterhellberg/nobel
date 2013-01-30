# encoding: utf-8

require_relative '../spec_helper'

describe "Affiliation" do
  subject { Nobel::Affiliation }

  it "can be blank" do
    a = subject.new

    a.name.must_equal    nil
    a.country.must_equal nil
    a.city.must_equal    nil
  end

  it "returns the affiliation name" do
    subject.new('name' => 'foo').name.must_equal 'foo'
  end

  it "returns the affiliation country" do
    subject.new('country' => 'bar').country.must_equal 'bar'
  end

  it "returns the affiliation city" do
    subject.new('city' => 'baz').city.must_equal 'baz'
  end
end
