class Booking < ApplicationRecord
  belongs_to :user
  has_many :services_bookings
end
