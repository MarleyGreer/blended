class AddFavouritesAndArchiveToChat < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :user_favourite, :boolean, default: false
    add_column :chats, :artist_favourite, :boolean, default: false
    add_column :chats, :user_archive, :boolean, default: false
    add_column :chats, :artist_archive, :boolean, default: false
  end
end
