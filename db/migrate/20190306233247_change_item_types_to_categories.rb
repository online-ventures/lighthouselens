class ChangeItemTypesToCategories < ActiveRecord::Migration[5.2]
  def change
    rename_table :item_types, :categories
  end
end
