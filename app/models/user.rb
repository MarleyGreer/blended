class User < ApplicationRecord
  has_one :artist, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_one_attached :photo
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :messages, through: :chats, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of   :first_name
  validates_presence_of   :last_name
  validates_presence_of   :address
  validates :username, uniqueness: true

  def has_bookmark?(blob)
    bookmarks.map(&:blob).include?(blob)
  end

  def bookmark_of(blob)
    bookmarks.find_by(active_storage_blob: blob)
  end

  def received_messages
    Message.joins(:chat).where(chats: { artist: self.artist}).or(Message.joins(:chat).where(chats: { user: self })).where.not(messages: { user: self })
  end
end
