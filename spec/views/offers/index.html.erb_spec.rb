require 'spec_helper'

describe "offers/index" do
  before(:each) do
    assign(:offers, [
      stub_model(Offer,
        :business_name => "Business Name",
        :address_1 => "Address 1",
        :postal_code => 1,
        :latitude => 1.1,
        :longitude => 1.2,
        :radius => 5
      ),
      stub_model(Offer,
        :business_name => "Business Name",
        :address_1 => "Address 2",
        :postal_code => 1,
        :latitude => 1.1,
        :longitude => 1.2,
        :radius => 5
      )
    ])
  end

  it "renders a list of offers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Business Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address 1".to_s, :count => 1
    assert_select "tr>td", :text => "Address 2".to_s, :count => 1
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.1.to_s, :count => 2
    assert_select "tr>td", :text => 1.2.to_s, :count => 2
    assert_select "tr>td", :text => "5.0", :count => 2
  end
end
