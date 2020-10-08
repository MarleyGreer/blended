class Booking < ApplicationRecord
  belongs_to :user
  has_many :services_bookings
  has_many :reviews, dependent: :destroy
end
