class CreateInquiryResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiry_responses do |t|
      t.integer :inquiry_id
      t.string :code
      t.string :message

      t.timestamps
    end
  end
end
