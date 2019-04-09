class AddDraftToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :draft, :boolean, default: true
  end
end
