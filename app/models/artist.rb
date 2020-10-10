class Artist < ApplicationRecord
  validates :description, presence: true
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :services_bookings, through: :services, dependent: :destroy
  has_many :bookings
  has_many :chats
  has_many :messages, through: :chats, dependent: :destroy
end
