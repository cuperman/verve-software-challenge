json.array!(@offers) do |offer|
  json.extract! offer, :id, :business_name, :address_1, :address_2, :city, :state, :country, :postal_code, :postal_code_suffix, :phone_number, :latitude, :longitude, :radius
  json.url offer_url(offer, format: :json)
end