class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  validates :start_date, :end_date, :number_of_guests, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }

  enum status: { pending: 0, processing_payment: 1, confirmed: 2, cancelled: -1 }
end
