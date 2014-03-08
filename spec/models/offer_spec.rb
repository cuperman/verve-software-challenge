require 'spec_helper'

describe Offer do
  it "should have address equal to address 1 and address 2" do
    Offer.new(
      address_1: "1234 Sesame St."
    ).address.should == "1234 Sesame St."
    
    Offer.new(
      address_1: "1234 Sesame St.",
      address_2: "Suite 3"
    ).address.should == "1234 Sesame St. Suite 3"
  end
  
  it "should have full_postal_code which includes suffix" do
    Offer.new(
      postal_code: 12345
    ).full_postal_code.should == "12345"
    
    Offer.new(
      postal_code: 12345,
      postal_code_suffix: 6789
    ).full_postal_code.should == "12345-6789"
  end
end