class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table "users", id: :serial, force: :cascade do |t|
      t.string "email", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "first_name"
      t.string "last_name"
      t.string "auth_id"
      t.jsonb "data", default: {}
      t.string "permissions", default: [], array: true
      t.index ["auth_id"], name: "index_users_on_auth_id"
    end
  end
end
