class RemoveDurationFromServices < ActiveRecord::Migration[6.0]
  def change
    remove_column :services, :duration, :datetime
  end
end
