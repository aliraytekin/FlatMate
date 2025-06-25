class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.integer :number_of_guests
      t.float :total_price
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
