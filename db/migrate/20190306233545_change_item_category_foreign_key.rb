class ChangeItemCategoryForeignKey < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :type, :category_id
  end
end
