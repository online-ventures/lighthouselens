class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :type
      t.string :title
      t.string :description
      t.integer :price
      t.boolean :publish
      t.string :comments
      t.string :main_photo
    end
  end
end
