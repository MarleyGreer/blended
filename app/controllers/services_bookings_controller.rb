class ServicesBookingsController < ApplicationController

  def create
    @booking_id = params[:booking_id].to_i
    @services_selection = params[:services_booking][:service].drop(1)
    @services_selection.each do |id|
      @services_booking = ServicesBooking.new
      @services_booking.service_id = id.to_i
      @services_booking.booking_id = @booking_id
      @services_booking.save
    end
  end
end
