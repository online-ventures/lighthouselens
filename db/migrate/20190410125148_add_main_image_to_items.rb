class AddMainImageToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :main_image_id, :integer
  end
end
