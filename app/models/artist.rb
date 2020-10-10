class Artist < ApplicationRecord
  validates :description, presence: true
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :services_bookings, through: :services, dependent: :destroy
  has_many :bookings

  def unavailable_times
    bookings.pluck(:start_time, :end_time).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
