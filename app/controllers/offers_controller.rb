class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_offer, only: %i[show edit update destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    if params[:query].present?
      @offers = Offer.search_by_offers(params[:query])
    else
      @offers = policy_scope(Offer)
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @review = Review.new
    @review.offer = @offer
    @reviews = @offer.reviews.includes(:user)
    authorize @offer
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(offers_params)
    @offer.user = current_user

    authorize @offer


    if @offer.save
      redirect_to @offer
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @offer
  end

  def update
    authorize @offer

    if @offer.update(offers_params)
      redirect_to @offer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @offer

    @offer.destroy
    redirect_to root_path, notice: 'Offer was successfully deleted.'
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offers_params
    params.require(:offer).permit(:title, :address, :description, :price_per_night, :number_of_bathrooms, :number_of_beds,
                                  :guests_limit, :property_type, photos: [])
  end
end
