class RemoveCategoryFromArtists < ActiveRecord::Migration[6.0]
  def change
    remove_column :artists, :category, :string
  end
end
