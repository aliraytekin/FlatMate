class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price_per_night, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number_of_bathrooms, :number_of_beds, :guests_limit, numericality: { only_integer: true }

  PROPERTY_TYPES = ["Apartment", "House", "Studio", "Villa", "Cabin"]
  validates :property_type, inclusion: { in: PROPERTY_TYPES }

  #enum status: { pending: 0, processing_payment: 1, confirmed: 2, cancelled: -1 }

  # include PgSearch::Model
  # pg_search_scope :search_by_offers,
  #                 against: %i[title description],
  #                 using: {
  #                   tsearch: { prefix: true }
  #                 }
end
