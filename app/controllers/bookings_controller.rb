class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :confirm, :decline, :cancel]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def decline
  end

  def cancel
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
    params.require(:booking).permit(:start_time, :end_time, :quantity)
  end
end
