class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :details, :edit, :confirm, :decline, :cancel]

  def index
    @bookings = current_user.bookings
  end

  def all
    @bookings = Booking.where(artist: current_user)
  end


  def show
    @booking = Booking.find(params[:id])
    @artist = Artist.find(params[:artist_id])
    @services_booking = ServicesBooking.new
  end

  def create
    @booking = Booking.new
    @artist = Artist.find(params[:artist_id])
    @booking.status = "pending"
    @booking.user = current_user
    @booking.artist = @artist
    if @booking.save
      redirect_to artist_booking_path(@artist, @booking)
    else
      redirect_to new_user_session_path
    end
  end

  def details
    @services_names_qty = @booking.services_bookings.map do |services_booking|
      service = Service.find(services_booking.service_id)
      [service.name, services_booking.quantity]
    end
  end

  def edit
  end

  def update
  end

  def confirm
    @booking.status = "confirmed"
    @booking.save
    redirect_to details_booking_path(@booking)
  end

  def decline
    @booking.status = "declined"
    @booking.save
    redirect_to details_booking_path(@booking)
  end

  def cancel
    @booking.status = "cancelled"
    @booking.save
    redirect_to details_booking_path(@booking)
  end

  def pending
  end

  def confirmed
  end

  def declined
  end

  def cancelled
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
