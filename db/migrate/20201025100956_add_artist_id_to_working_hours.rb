class AddArtistIdToWorkingHours < ActiveRecord::Migration[6.0]
  def change
    add_reference :working_hours, :artist, null: false, foreign_key: true
  end
end
