class AddStatusToBookings < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:bookings, :status)
      add_column :bookings, :status, :integer, null: false, default: 0
    end
  end
end
