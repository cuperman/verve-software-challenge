require 'spec_helper'

describe "offers/show" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :business_name => "Business Name",
      :address => "Address",
      :city => "City",
      :state => "State",
      :postal_code => 1,
      :country => "Country",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Business Name/)
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/1/)
    rendered.should match(/Country/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
  end
end
