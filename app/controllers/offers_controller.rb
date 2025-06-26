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
  end

  def update
  end

  def destroy
  end

  private

  def set_params
    params.require(:offer).permit(:title, :description, :address, :price_per_night, :number_of_beds, :number_of_bathrooms)
  end
end
