class Review < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :rating,
            inclusion: { in: 1..5, message: "must be a number between 1 and 5" }

  validates :comment,
            presence: true,
            length: { maximum: 300, message: "is too long (maximum is 300 characters)" }
end
