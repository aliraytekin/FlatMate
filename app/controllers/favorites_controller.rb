class FavoritesController < ApplicationController
  before_action :set_offer, only: %i[create destroy]

  def index
    @favorites = Favorite.all
  end

  def create
    current_user.favorites.find_or_create_by(offer: @offer)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @offer, notice: "Added to favorites" }
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(offer: @offer)
    favorite&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @offer, notice: "Removed from favorites" }
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end
end
