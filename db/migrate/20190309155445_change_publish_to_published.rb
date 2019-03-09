class ChangePublishToPublished < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :publish, :published
  end
end
