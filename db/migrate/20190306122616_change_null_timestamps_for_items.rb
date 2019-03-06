class ChangeNullTimestampsForItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :created_at, :datetime, null: false
    change_column :items, :updated_at, :datetime, null: false
  end
end
