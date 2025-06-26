class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price_per_night, presence: true
  validates :number_of_beds, :number_of_bathrooms, presence: true

  PROPERTY_TYPES = ["Apartment", "House", "Studio", "Villa", "Cabin"]
  validates :property_type, inclusion: { in: PROPERTY_TYPES }
end
