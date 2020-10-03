class ChangeNamesInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
    change_column_null :users, :address, true
  end
end
