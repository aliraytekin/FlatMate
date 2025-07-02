class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  validates :start_date, :end_date, :number_of_guests, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
  validate :overlapping_dates

  attribute :status, :integer
  enum status: { refused: -2, cancelled: -1, pending: 0, accepted: 1 }

  def duration
    end_date - start_date
  end

  def calculate_total_price
    self.total_price = offer.price_per_night * duration
  end

  def overlapping_dates
    return unless offer

    overlapping = offer.bookings.where.not(id: id).where(
      "start_date < ? AND end_date > ?", end_date, start_date
    )

    errors.add(:base, "These dates are already booked") if overlapping.exists?
  end
end
