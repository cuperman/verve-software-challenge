require 'spec_helper'

describe "offers/edit" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :business_name => "MyString",
      :address_1 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :postal_code => 1,
      :country => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders the edit offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offer_path(@offer), "post" do
      assert_select "input#offer_business_name[name=?]", "offer[business_name]"
      assert_select "input#offer_address_1[name=?]", "offer[address_1]"
      assert_select "input#offer_city[name=?]", "offer[city]"
      assert_select "input#offer_state[name=?]", "offer[state]"
      assert_select "input#offer_postal_code[name=?]", "offer[postal_code]"
      assert_select "input#offer_country[name=?]", "offer[country]"
      assert_select "input#offer_latitude[name=?]", "offer[latitude]"
      assert_select "input#offer_longitude[name=?]", "offer[longitude]"
    end
  end
end