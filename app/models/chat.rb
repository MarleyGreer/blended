class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_many :messages, dependent: :destroy
end
