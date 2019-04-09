class SetInitialStateOfDrafts < ActiveRecord::Migration[5.2]
  def up
    Item.update_all(draft: false)
  end
end
