class Artist < ApplicationRecord
  validates :description, presence: true
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :services
  has_many :services_bookings, through: :services, dependent: :destroy
end
