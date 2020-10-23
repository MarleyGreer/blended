class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks.order("position")
  end

  def create
    blob = ActiveStorage::Blob.find(params[:blob])
    bookmark = Bookmark.new(user: current_user, active_storage_blob: blob)
    bookmark.position = current_user.bookmarks.count
    bookmark.save!
    redirect_to request.referrer
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to request.referrer
  end
end
