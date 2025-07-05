class BookingsController < ApplicationController
  before_action :set_offer, only: %i[new create]
  before_action :set_booking, only: %i[show edit update]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

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
    # authorize booking, :update_status?

    booking.accepted!
    redirect_to bookings_path, notice: "Booking accepted."
  end

  def refuse
    booking = Booking.find(params[:id])
    # authorize booking, :update_status?

    booking.refused!
    redirect_to bookings_path, notice: "Booking cancelled."
  end

  def cancel
    booking = Booking.find(params[:id])
    # authorize booking, :cancel?

    booking.cancelled!
    redirect_to bookings_path, notice: "Booking cancelled."
  end

  def payment
    @booking = Booking.find(params[:id])
    # authorize @booking, :payment?

    @payment_intent = Stripe::PaymentIntent.create(
      amount: @booking.calculate_total_price.to_i,
      currency: 'eur',
      metadata: { booking_id: @booking.id }
    )
  end

  def success
    @booking = Booking.find(params[:id])
    authorize @booking, :success?
    redirect_to confirmation_booking_path(@booking), notice: "Your request to book will be confirmed by a host soon!"
  end

  def confirmation
    @booking = Booking.find(params[:id])
    authorize @booking, :confirmation?
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
    authorize @offer
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    # authorize @booking
  end
end
