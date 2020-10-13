class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :destroy]

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def show
    if user_signed_in?
    @chat = Chat.where(artist: current_user.artist, user: @artist.user).or(Chat.where(artist: @artist, user: current_user)).first
    end
    @bookings = @artist.bookings
    @reviews = []
    @bookings.each do |booking|
      booking.reviews.each do |review|
        if review.present?
          @reviews << review
        end
      end
    end

    @rating_sum = 0
    @reviews.each { |review| @rating_sum += review.rating }
    @rating_sum == 0 ? @average_rating = 0 : @average_rating = @rating_sum / @reviews.count
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user = current_user
    if @artist.save
      redirect_to artist_path(@artist)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @artist.update(artist_params)
    redirect_to artist_path(@artist)
  end

  def destroy
    @artist.destroy
    redirect_to artists_path
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:description, :qualifications, photos: [])
  end
end
