class AddPositionToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :position, :integer
  end
end
