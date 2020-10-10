class AddQuantityToServicesBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :services_bookings, :quantity, :integer
  end
end
