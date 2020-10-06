class ChangeTimeToBeDurationInServices < ActiveRecord::Migration[6.0]
  def change
    rename_column :services, :time, :duration
  end
end
