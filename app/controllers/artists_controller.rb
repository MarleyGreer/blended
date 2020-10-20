class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :destroy]

  def index
    # Search by artist location.
    if params[:query].present?
      # Can only use Geocoder near method on User class.
      @users = User.near(params[:query])
      @artists = @users.each.map { |user| user.artist if user.artist.present? }
      @artist_users = @users.each.map do |user|
        if user.artist.present? && user.latitude.present? && user.longitude.present?
          user
        end
      end

      @markers = @artist_users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
      }
      end
    # Search by artist information.
    elsif
      params[:query_artist].present?
      sql_query = " \
        artists.description @@ :query \
        OR artists.qualifications @@ :query \
        OR users.username @@ :query \
        OR users.first_name @@ :query \
        OR users.last_name @@ :query \
      "
      @artists = Artist.joins(:user).where(sql_query, query: "%#{params[:query_artist]}%")
    # No search.
    else
      @artists = Artist.all
      @artist_users = []
      Artist.all.each do |artist|
        if artist.user.latitude.present? && artist.user.longitude.present?
          @artist_users <<artist.user
        end
      end
      @markers = @artist_users.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
        }
      end
    end
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

  def top
    @blobs = Bookmark.group(:active_storage_blob_id)
    .select(:active_storage_blob_id)
    .count # Gives an array of hashes, each one containing asb_id and count
    .sort_by { |_k, v| - v } # Sorts by count
    .map { |k, v|  { blob: ActiveStorage::Blob.find(k) , count: v }} # Transforms them into a nicer hash to be used on the view with the full blob instead of just the id and it's count
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:description, :qualifications, photos: [])
  end
end
