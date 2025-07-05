class ReviewsController < ApplicationController
  before_action :set_offer, only: %i[new create edit update destroy]
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = Review.new
    @review.offer = @offer
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.offer = @offer
    @review.user = current_user

    authorize @review

    if @review.save
      redirect_to @offer, notice: "Your review was successfully created!"
    else
      @reviews = @offer.reviews.includes(:user)
      render "offers/show", status: :unprocessable_entity
    end
  end

  def edit
    authorize @review
  end

  def update
    authorize @review

    if @review.update(review_params)
      redirect_to offer_path(@offer), notice: "Review updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @review

    @review.destroy
    redirect_to offer_path(@offer), notice: "Review deleted."
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def set_review
    @review = @offer.reviews.find(params[:id])
  end
end
