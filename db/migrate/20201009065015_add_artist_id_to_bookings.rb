class AddArtistIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :artist, foreign_key: true
  end
end
