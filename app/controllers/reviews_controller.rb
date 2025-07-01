class ReviewsController < ApplicationController
  before_action :set_offer, only: %i[new create]
  before_action :authorize_user!, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.offer = @offer
    @review.user = current_user
    if @review.save
      redirect_to @offer, notice: "Your review was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def authorize_user!
    offer = Offer.find(params[:offer_id])

    has_booking = Booking.exists?(offer: offer, user: current_user)

    unless has_booking
      redirect_to root_path, alert: "You are not authorized to see this page!"
    end
  end
end
