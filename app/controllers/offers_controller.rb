class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_offer, only: %i[show update destroy]


  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offers_params)
    @offer.user = current_user
    if @offer.save
      redirect_to @offer
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update

    if @offer.update(offers_params)
      redirect_to @offer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offers_params
    params.require(:offer).permit(:title, :address, :description, :price_per_night, :number_of_bathrooms, :number_of_beds,
                                  :guests_limit, :property_type)
  end
end
