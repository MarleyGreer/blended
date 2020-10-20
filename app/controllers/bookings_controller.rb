class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :details, :edit, :confirm, :decline, :cancel]

  def index
    @bookings = current_user.bookings
  end

  def all
    @bookings = Booking.where(artist: current_user)
  end

  def new
    @booking = Booking.new
    @artist = Artist.find(params[:artist_id])
    @booking.user = current_user
    @booking.artist = @artist
    @artist.services.each do |s|
      @booking.services_bookings.build(service_id: s.id)
    end
  end
  

  def show
    @services_names_qty = @booking.services_bookings.map do |services_booking|
      service = Service.find(services_booking.service_id)
      [service.name, services_booking.quantity]
    end
    @booking = Booking.find(params[:id])
    @artist = Artist.find(params[:artist_id])
    @services_booking = ServicesBooking.new
  end

  def selectdate
    @booking = Booking.new
    @artist = Artist.find(params[:booking][:artist_id])
    @booking.user = current_user
    @booking.artist = @artist
    @total_duration = 0
    params[:booking][:services_bookings_attributes].each do |s|
      @booking.services_bookings.build(service_id: s[1][:service_id], quantity: s[1][:quantity].to_i) if s[1][:quantity].to_i > 0
    end
    @booking.services_bookings.each do |s|
      @duration = s.service.duration * s.quantity
      @total_duration = @total_duration + @duration
    end  
    @booking.total_duration = @total_duration
    @times = []
  end

  def selecttime
    @booking = Booking.new
    @artist = Artist.find(params[:booking][:artist_id])
    @booking.user = current_user
    @booking.artist = @artist
    @total_duration = 0
    params[:booking][:services_bookings_attributes].each do |s|
      @booking.services_bookings.build(service_id: s[1][:service_id], quantity: s[1][:quantity].to_i)  if s[1][:quantity].to_i > 0
    end
    @booking.services_bookings.each do |s|
      @duration = s.service.duration * s.quantity
      @total_duration = @total_duration + @duration
    end  
    @booking.total_duration = @total_duration
    @booking.start_time = Date.strptime(params[:booking][:start_time], '%d-%m-%Y').to_datetime
    @times = []
    @starttime = @booking.start_time + 540*60
    @slottime = @starttime
    @finalbooking = @starttime + 720*60
    @endtime = @slottime + @total_duration * 60 
    while @endtime <= @finalbooking do
      @times << ["#{@slottime.strftime('%H:%M')} - #{@endtime.strftime('%H:%M')}", @slottime]
      @slottime = @slottime + 30*60
      @endtime = @slottime + @total_duration * 60
    end
    @times2 = []
    @times.each {|time| @times2 << [time[1],(time[1]+@total_duration*60)]}
    @a = Booking.booking_date(params[:booking][:start_time].to_date)
    @range = []
    @a.each {|booking| @range << [booking.start_time,booking.end_time]}
    @disabled = []
    @range.each { |range| @times2.each {|time| @disabled << time if ((range[0]..range[1]).cover?(time[0]) || (range[0]..range[1]).cover?(time[1]))}}
    @disabled = @disabled.sort
    @disabled2 = []
    @disabled.each {|disabled| @disabled2 << ["#{disabled.min.strftime('%H:%M')} - #{disabled.max.strftime('%H:%M')}", disabled[0]]}
    @disabled = @disabled2
    @timestest = @times - @disabled
  end

  def create
    @booking = Booking.new
    @booking.status = "pending"
    @booking.user = current_user
    @artist = Artist.find(params[:booking][:artist_id].to_i)
    @booking.artist = @artist
    @booking.start_time = params[:booking][:start_time]
    @booking.total_duration = params[:booking][:total_duration].to_i
    @booking.end_time = @booking.start_time + @booking.total_duration * 60
    params[:booking][:services_bookings_attributes].each do |s|
      @booking.services_bookings.build(service_id: s[1][:service_id], quantity: s[1][:quantity])
    end
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
