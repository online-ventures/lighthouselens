class AddDeletedAtToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :deleted_at, :datetime, default: nil
  end
end
