class User < ApplicationRecord
  has_one :artist, dependent: :destroy
  has_one_attached :photo
  has_many :chats
  has_many :messages, through: :chats, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of   :first_name
  validates_presence_of   :last_name
  validates_presence_of   :address
  validates :username, uniqueness: true
end
