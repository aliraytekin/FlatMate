class Offer < ApplicationRecord
  belongs_to :user

  PROPERTY_TYPES = ["Apartment", "House", "Studio", "Villa", "Cabin"]
end
