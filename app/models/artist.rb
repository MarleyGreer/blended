class Artist < ApplicationRecord
  validates :description, presence: true
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :services_bookings, through: :services, dependent: :destroy
  has_many :bookings
  has_many :chats
  has_many :messages, through: :chats, dependent: :destroy
  scope :filter_by_category, -> (category) { where category: category }

  def rating
    reviews = []
    bookings.each do |booking|
      booking.reviews.each do |review|
        review.present?
        reviews << review
      end
    end

    rating_sum = 0
    reviews.each { |review| rating_sum += review.rating }
    rating_sum.zero? ? average_rating = 0 : average_rating = rating_sum / reviews.count
    average_rating
  end
end
