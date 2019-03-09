class AddFeaturedToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :featured, :boolean, default: false
  end
end
