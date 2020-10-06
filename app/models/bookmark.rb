class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :active_storage_blob, class_name: "ActiveStorage::Blob", foreign_key: "active_storage_blob_id"

  def blob
    active_storage_blob
  end
end
