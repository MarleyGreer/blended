class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_many :services_bookings
  has_many :reviews, dependent: :destroy
end
