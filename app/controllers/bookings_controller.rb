class BookingsController < ApplicationController
  before_action :set_offer, only: %i[new create]
  before_action :set_booking, only: %i[show edit update payment success]
  before_action :authorize_user!, only: %i[payment success]

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
      redirect_to payment_booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
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

  def payment
    @booking = Booking.find(params[:id])
    @payment_intent = Stripe::PaymentIntent.create(
      amount: @booking.calculate_total_price.to_i,
      currency: 'eur',
      metadata: { booking_id: @booking.id }
    )
  end

  def success
    redirect_to root_path, notice: "Your request to book will be confirmed by a host soon!"
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

  def authorize_user!
    unless current_user == @booking.user
      redirect_to root_path, alert: "You are not authorized to see this page"
    end
  end
end
