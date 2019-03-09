class ChangeNameForBuyers < ActiveRecord::Migration[5.2]
  def change
    rename_column :buyers, :first_name, :name
    remove_column :buyers, :last_name, :string
  end
end
