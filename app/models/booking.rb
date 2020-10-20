class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_many :services_bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  scope :booking_date, -> (start_date) { where start_time: start_date.all_day}

  accepts_nested_attributes_for :services_bookings
  attr_accessor :start_hour, :qty, :service_name

end
