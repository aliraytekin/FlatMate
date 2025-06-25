class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :address
      t.integer :number_of_bathrooms
      t.integer :number_of_beds
      t.integer :guests_limit
      t.float :price_per_night
      t.string :property_type
      t.float :ratings
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
