class AddTotalDurationToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :total_duration, :integer
  end
end
