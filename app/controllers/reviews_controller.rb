class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update]

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @review.booking = @booking
    @artist = @booking.artist
    if @review.save
      redirect_to artist_path(@artist)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    @artist = @review.booking.artist
    redirect_to artist_path(@artist)
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating, :reply)
  end
end
