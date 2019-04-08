class ChangeBuyerToInquiry < ActiveRecord::Migration[5.2]
  def change
    rename_table :buyers, :inquiries
  end
end
