class BookingsController < ApplicationController
  before_action :set_booking, only: [:details, :edit, :confirm, :decline, :cancel]

  def index
    @bookings = current_user.bookings
    @statusselect = { prompt: true, prompt: "Status" }
    status_filter(@bookings) if params[:booking].present?
  end

  def all
    if user_signed_in?
      @bookings = Booking.where(artist: current_user.artist)
    end
    @statusselect = { prompt: true, prompt: "Status" }
    status_filter(@bookings) if params[:booking].present?
  end

  def status_filter(bookings)
    if params[:booking][:status] != ""
      @bookings = @bookings.select { |booking| booking.status == params[:booking][:status] }
    end
    @bookings
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
    @booking = Booking.find(params[:id])
    @artist = @booking.artist
  end

  def selectdate
    @booking = Booking.new
    @artist = Artist.find(params[:booking][:artist_id])
    @working_hours = @artist.working_hour
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
    @starttimes = {
      0 => @artist.working_hour.sundaystart_time,
      1 => @artist.working_hour.mondaystart_time,
      2 => @artist.working_hour.tuesdaystart_time,
      3 => @artist.working_hour.wednesdaystart_time,
      4 => @artist.working_hour.thursdaystart_time,
      5 => @artist.working_hour.fridaystart_time,
      6 => @artist.working_hour.saturdaystart_time,
      7 => @artist.working_hour.sundaystart_time
    }
    @endtimes = {
      0 => @artist.working_hour.sundayend_time,
      1 => @artist.working_hour.mondayend_time,
      2 => @artist.working_hour.tuesdayend_time,
      3 => @artist.working_hour.wednesdayend_time,
      4 => @artist.working_hour.thursdayend_time,
      5 => @artist.working_hour.fridayend_time,
      6 => @artist.working_hour.saturdayend_time,
      7 => @artist.working_hour.sundayend_time
    }
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
    #starttime needs to be updated to reflect artist_start time currently its 9.00am
    @startday = @booking.start_time.wday
    @slottime = DateTime.new(@booking.start_time.year,@booking.start_time.month,@booking.start_time.day, @starttimes[@startday].hour, @starttimes[@startday].min)
    #finalbooking needs to be updated to reflect artist_finish time currently its 6.00pm

    @finalbooking = DateTime.new(@booking.start_time.year,@booking.start_time.month,@booking.start_time.day, @endtimes[@startday].hour, @endtimes[@startday].min)
    @endtime = @slottime + @total_duration.minutes

    while @endtime <= @finalbooking do
      @times << ["#{@slottime.strftime('%H:%M')} - #{@endtime.strftime('%H:%M')}", @slottime]
      @slottime = @slottime + 30.minutes
      @endtime = @slottime + @total_duration.minutes
    end

    @times2 = []
    @times.each {|time| @times2 << [time[1],(time[1] + @total_duration.minutes )]}
    @a = Booking.where(artist_id: params[:booking][:artist_id]).booking_date(params[:booking][:start_time].to_date)
    @range = []
    @a.each {|booking| @range << [booking.start_time,booking.end_time]}
    @disabled = []
    @range.each { |range| @times.each {|time| @disabled << time[1] if ((range[0]..range[1]).cover?(time[1]) || (range[0]..range[1]).cover?(time[1]))}}
    @disabled = @disabled.sort
    @disabled2 = []
    @timestest = @times
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

      @chat = Chat.where(artist: current_user.artist, user: @artist.user).or(Chat.where(artist: @artist, user: current_user)).first if user_signed_in?
      if @chat.nil?
        @chat = Chat.new
        @chat.user = current_user
        @chat.artist = @booking.artist
        @chat.save
      end
        @message = Message.new
        @message.user = current_user
        @message.chat = @chat
        @message.chat.user_archive = false
        @message.chat.artist_archive = false
        @message.content = "A new booking has been made by #{@booking.user.first_name} for  #{@booking.start_time.strftime("%e %b %y")}, jump into your jobs to confirm it now!"
        @message.save
      redirect_to booking_path(@booking.id)
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
    if params[:id] == "all"
      @booking = Booking.all

    else
      @booking = Booking.find(params[:id])
    end
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
