class RemoveQuantityFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :quantity, :integer
  end
end
