class Offer < ActiveRecord::Base
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
end
