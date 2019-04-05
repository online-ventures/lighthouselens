class DropMainPhotoFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :main_photo, :string
  end
end
