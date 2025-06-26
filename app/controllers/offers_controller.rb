class OffersController < ApplicationController
  before_action :set_offer, only: %i[show create edit update]

  def index
    @offers = Offer.all
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def create
  end

  def edit
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

  def set_flat
    @offer = Offer.find(params[:id])
  end

  def offers_params
    params.require(:offer).permit(:title, :address, :description, :price_per_night, :number_of_bathrooms, :number_of_beds,
                                  :guests_limit, :property_type)
  end
end
