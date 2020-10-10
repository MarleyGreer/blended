class RemoveTotalTimeFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :total_time, :datetime
  end
end
