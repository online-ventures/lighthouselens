class AddTimestampsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :created_at, :datetime, null: true
    add_column :items, :updated_at, :datetime, null: true
  end
end
