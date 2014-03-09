class Offer < ActiveRecord::Base
  VerveCoordinates = {
    latitude: 33.1243208,
    longitude: -117.32582479999996
  }

  validates :business_name, presence: true
  validates :address_1, presence: true
  validates :postal_code, presence: true

  validates :latitude, presence: true,
                        numericality: { greater_than_or_equal_to: -90,
                                        less_than_or_equal_to: 90 }
  validates :longitude, presence: true,
                        numericality: { greater_than_or_equal_to: -180,
                                        less_than_or_equal_to: 180 }
  validates :radius, presence: true,
                     numericality: { greater_than: 0 }

  def address
    [address_1, address_2].compact.join(" ")
  end

  def full_postal_code
    [postal_code, postal_code_suffix].compact.join("-")
  end

  def distance_from_verve
    Haversine.distance(VerveCoordinates[:latitude],
                       VerveCoordinates[:longitude],
                       latitude,
                       longitude)
  end

  def miles_from_verve
    distance_from_verve.to_miles
  end
end
