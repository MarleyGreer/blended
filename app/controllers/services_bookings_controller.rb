class ServicesBookingsController < ApplicationController

  def new
    @booking = Booking.new
    @artist = Artist.find(params[:artist_id])
    @booking.status = "pending"
    @booking.user = current_user
    @booking.artist = @artist
    @service_booking = ServicesBooking.new
  end
  

  def create
    @booking_id = params[:booking_id].to_i
    booking_duration = 0
    booking_totalprice = 0
    @services_selected_elements = params[:services_booking][:service].reject { |service| service.empty? }
    @services_selected = @services_selected_elements.map { |service| service.to_i }
    @services_qty = @services_selected.map { |service| params["#{service.to_i}"].to_i }
    @services_selected_qty = @services_selected.zip(@services_qty).map { |service, qty| [service , qty] }
    @services_selected_qty.each do |id, qty|
      @services_booking = ServicesBooking.new
      @services_booking.service_id = id
      @services_booking.booking_id = @booking_id
      @services_booking.quantity = qty
      service = Service.find(id)
      booking_duration += (service.duration * qty)
      booking_totalprice += (service.price * qty)
      @services_booking.save
    end
    update_booking(@booking_id, booking_duration, booking_totalprice)
    raise
  end

  def update_booking(booking_id, booking_duration, booking_totalprice)
    @booking = Booking.find(booking_id)
    @booking.start_time = params[:services_booking][:booking]
    @booking.end_time = @booking.start_time + (booking_duration * 60)
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
