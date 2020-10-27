class ChangeDescriptionAndQualificationsInputToText < ActiveRecord::Migration[6.0]
  def change
    change_column :artists, :description, :text
    change_column :artists, :qualifications, :text
  end
end
