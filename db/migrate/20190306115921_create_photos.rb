class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :item_id
      t.integer :rank
      t.string :name
    end
  end
end
