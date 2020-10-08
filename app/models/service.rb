class Service < ApplicationRecord
  belongs_to :artist
  has_many :services_bookings
  has_many :bookings, through: :services_bookings
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :duration, presence: true
end
