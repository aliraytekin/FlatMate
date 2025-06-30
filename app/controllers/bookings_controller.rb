class BookingsController < ApplicationController
  before_action :set_offer, only: %i[new create]
  before_action :set_booking, only: %i[show edit update accept refuse]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.offer = @offer
    @booking.user = current_user
    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to @booking, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def accept
    booking = Booking.find(params[:id])
    if booking.offer.user == current_user
      booking.accepted!
      redirect_to bookings_path, notice: "Booking accepted."
    else
      redirect_to bookings_path, alert: "You are not authorised to do that"
    end
  end

  def refuse
    booking = Booking.find(params[:id])
    if booking.offer.user == current_user
      booking.refused!
      redirect_to bookings_path, notice: "Booking cancelled."
    else
      redirect_to bookings_path, alert: "You are not authorised to do that"
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
