class Booking < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :quantity, presence: true
  validates :total_time, presence: true
  validates :total_price, presence: true
  validates :status, inclusion: { in: ["pending", "confirmed", "declined", "cancelled"] }

  belongs_to :user
  belongs_to :services_bookings
  has_many :reviews
end
