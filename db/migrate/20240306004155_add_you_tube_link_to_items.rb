class AddYouTubeLinkToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :youtube_url, :string
  end
end
