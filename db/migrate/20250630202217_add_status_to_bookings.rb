class AddStatusToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :status, :string, default: "active"
  end
end
