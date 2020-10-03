class Service < ApplicationRecord
  belongs_to :artist
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :time, presence: true
end
