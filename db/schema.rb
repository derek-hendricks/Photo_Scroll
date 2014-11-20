ActiveRecord::Schema.define(version: 20141120103752) do

  create_table "author_follows", force: true do |t|
    t.integer  "author_id"
    t.integer  "follow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: true do |t|
    t.string   "full_name"
    t.string   "username"
    t.string   "password"
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",             default: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "authors", ["email"], name: "index_authors_on_email", unique: true

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "favourites", id: false, force: true do |t|
    t.integer "fav_author_id"
    t.integer "message_id"
  end

  create_table "images", force: true do |t|
    t.string   "caption"
    t.text     "description"
    t.string   "url"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.boolean  "flagged"
  end

  create_table "messages", force: true do |t|
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "duration"
    t.date     "due_date"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "priority"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "avatar_url"
    t.string   "provider"
    t.string   "profile_url"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid"

end
