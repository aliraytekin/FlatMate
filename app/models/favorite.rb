class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :offer_id, uniqueness: { scope: :user_id }
end
