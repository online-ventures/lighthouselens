class AddSequenceToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :sequence, :integer
  end
end
