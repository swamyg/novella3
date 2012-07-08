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

ActiveRecord::Schema.define(:version => 20120514021624) do

  create_table "chapters", :force => true do |t|
    t.string   "title",      :limit => 128
    t.integer  "user_id",                   :null => false
    t.integer  "novel_id",                  :null => false
    t.integer  "number",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",                   :null => false
  end

  create_table "characters", :force => true do |t|
    t.string  "name",                         :null => false
    t.integer "novel_id",                     :null => false
    t.integer "user_id",                      :null => false
    t.string  "description"
    t.string  "character_type", :limit => 32
  end

  create_table "friends", :force => true do |t|
    t.integer  "friend_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", :force => true do |t|
    t.string   "name",       :limit => 32, :null => false
    t.string   "url",        :limit => 32, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locks", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "novel_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novels", :force => true do |t|
    t.string   "name",               :limit => 128
    t.integer  "user_id"
    t.integer  "genre_id",                          :null => false
    t.string   "cover"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "perma_link",                        :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.integer  "novel_id"
    t.string   "role",       :limit => 32, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name",               :limit => 32
    t.date     "dob"
    t.string   "webpage"
    t.string   "about_me"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                          :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "from_user_id",                        :null => false
    t.integer  "to_user_id",                          :null => false
    t.integer  "novel_id",                            :null => false
    t.string   "status",       :default => "pending"
    t.text     "message"
    t.text     "comment"
    t.boolean  "dismissed",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "text",       :limit => 32, :null => false
    t.string   "url",        :limit => 32, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :limit => 32
    t.string   "login",                     :limit => 32, :null => false
    t.string   "email",                     :limit => 64, :null => false
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
