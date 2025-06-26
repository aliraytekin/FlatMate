class OffersController < ApplicationController
  def index
    @offer = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.update(offers_params)
      redirect_to @offer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def offers_params
    params.require(:offer).permit(:title, :address, :description, :price_per_night, :number_of_bathrooms, :number_of_beds, :guests_limit, :property_type)
  end
end
