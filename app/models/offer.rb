class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price_per_night, presence: true, numericality: { only_float: true }
  validates :number_of_bathrooms, :number_of_beds, :guests_limit, numericality: { only_integer: true }

  PROPERTY_TYPES = ["Apartment", "House", "Villa", "Cabin"]
  validates :property_type, inclusion: { in: PROPERTY_TYPES }

  include PgSearch::Model
  pg_search_scope :search_by_offers,
                  against: %i[title description],
                  using: {
                    tsearch: { prefix: true }
                  }

  def average_rating
    reviews.average(:rating)&.round(2) || 0
  end
end
