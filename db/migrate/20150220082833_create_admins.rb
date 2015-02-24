class CreateAdmins < ActiveRecord::Migration
  def change
    create_table "admins", :force => true do |t|
    t.string   "first_name",                :limit => 50
    t.string   "last_name",                 :limit => 50
    t.string   "username"
    t.string   "email"
    t.string   "hashed_password",                         :default => "",   :null => false
    t.boolean  "enabled",                                 :default => true
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email"
  add_index "admins", ["first_name"], :name => "index_admins_on_first_name"
  add_index "admins", ["last_name"], :name => "index_admins_on_last_name"
  add_index "admins", ["remember_token"], :name => "index_admins_on_remember_token"
  end
end
