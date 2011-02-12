# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110211105015) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "comments", :force => true do |t|
    t.integer  "report_id"
    t.integer  "comment_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author"
  end

  add_index "comments", ["comment_id"], :name => "index_comments_on_comment_id"
  add_index "comments", ["report_id"], :name => "index_comments_on_report_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "reports", :force => true do |t|
    t.integer  "state_id"
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "subject"
    t.string   "description"
    t.string   "coordinates"
    t.string   "file_path"
    t.string   "pincolor"
    t.integer  "voted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "address"
  end

  add_index "reports", ["category_id"], :name => "index_reports_on_category_id"
  add_index "reports", ["state_id"], :name => "index_reports_on_state_id"
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "states", :force => true do |t|
    t.string  "name"
    t.integer "state_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "last_name"
    t.string   "phone"
    t.boolean  "is_anonym"
    t.boolean  "is_admin",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
