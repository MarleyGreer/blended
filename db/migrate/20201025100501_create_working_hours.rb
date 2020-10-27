class CreateWorkingHours < ActiveRecord::Migration[6.0]
  def change
    create_table :working_hours do |t|
      t.time :mondaystart_time
      t.time :mondayend_time
      t.time :tuesdaystart_time
      t.time :tuesdayend_time
      t.time :wednesdaystart_time
      t.time :wednesdayend_time
      t.time :thursdaystart_time
      t.time :thursdayend_time
      t.time :fridaystart_time
      t.time :fridayend_time
      t.time :saturdaystart_time
      t.time :saturdayend_time
      t.time :sundaystart_time
      t.time :sundayend_time
      t.string :holidays, array: true

      t.timestamps
    end
  end
end
