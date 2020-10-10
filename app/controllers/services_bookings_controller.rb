class ServicesBookingsController < ApplicationController

  def create
    @booking_id = params[:booking_id].to_i
    booking_duration = 0
    booking_totalprice = 0
    @services_selection = params[:services_booking][:service].drop(1)
    @services_selection.each do |id|
      @services_booking = ServicesBooking.new
      @services_booking.service_id = id.to_i
      @services_booking.booking_id = @booking_id
      service = Service.find(id)
      booking_duration += service.duration
      booking_totalprice += service.price
      @services_booking.save
    end
    update_booking(@booking_id, booking_duration, booking_totalprice)
  end

  def update_booking(booking_id, booking_duration, booking_totalprice)
    @booking = Booking.find(booking_id)
    @booking.start_time = params[:services_booking][:booking]
    @booking.end_time = @booking.start_time + booking_duration
    @booking.total_duration = booking_duration
    @booking.total_price = booking_totalprice
    @booking.save
    if @booking.save
      redirect_to details_booking_path(@booking)
    else
      render :show
    end
  end
end
