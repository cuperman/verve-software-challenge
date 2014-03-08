class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :business_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :country
      t.integer :postal_code
      t.integer :postal_code_suffix
      t.string :phone_number
      t.float :latitude
      t.float :longitude
      t.float :radius

      t.timestamps
    end
  end
end
