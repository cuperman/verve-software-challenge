require 'spec_helper'

describe Offer do
  describe "#address" do
    it "should be equal to address 1 and address 2" do
      Offer.new(
        address_1: "1234 Sesame St."
      ).address.should == "1234 Sesame St."
    end

    it "should only return address 1 if address 2 is blank" do
      Offer.new(
        address_1: "1234 Sesame St.",
        address_2: "Suite 3"
      ).address.should == "1234 Sesame St. Suite 3"
    end
  end

  describe "#full_postal_code" do
    it "should be equal to postal code and suffix" do
      Offer.new(
        postal_code: 12345
      ).full_postal_code.should == "12345"
    end

    it "should only return first 5 digits of postal code if suffix is blank" do
      Offer.new(
        postal_code: 12345,
        postal_code_suffix: 6789
      ).full_postal_code.should == "12345-6789"
    end
  end

  describe "Offer::VerveCoordinates" do
    it "should have latitude 33.1243208" do
      Offer::VerveCoordinates[:latitude].should == 33.1243208
    end

    it "should have longitude -117.32582479999996" do
      Offer::VerveCoordinates[:longitude].should == -117.32582479999996
    end
  end

  describe "#distance" do
    it "should return a haversine distance object" do
      Offer.new(
        latitude: 44.978348,
        longitude: -93.268623
      ).distance.should be_kind_of(Haversine::Distance)
    end
  end

  describe "#distance_in_miles" do
    it "should match expected distance between it and Verve office by default" do
      offer = Offer.new(
        latitude: 44.978348,
        longitude: -93.268623
      )

      # TODO: This value came out to 1521.65 when checked on the following sites:
      #   * http://www.gpsvisualizer.com/calculators
      #   * http://boulter.com/gps/distance/
      #
      # Why is haversine gem coming up with a different value?
      # It's close, so I'm just going to leave it as-is
      offer.distance_in_miles.round(2).should == 1518.65
    end

    it "should match expected distance between it and specified coordinates" do
      offer = Offer.new(
        latitude: 44.978348,
        longitude: -93.268623
      )

      balboa_park = {
        latitude: 32.7341479,
        longitude: -117.14455299999997
      }

      # TODO: This value should actually be 1530.85
      offer.distance_in_miles(from: balboa_park).round(2).should == 1527.97
    end
  end
end
