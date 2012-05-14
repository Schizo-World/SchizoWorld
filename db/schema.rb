# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120506225634) do

  create_table "announce_candidates", :force => true do |t|
    t.integer "announce_id"
    t.integer "author_id"
    t.boolean "accepted"
  end

  create_table "announces", :force => true do |t|
    t.string   "title"
    t.string   "location"
    t.integer  "job_id"
    t.string   "description"
    t.string   "date"
    t.integer  "author_id"
    t.integer  "author_type"
    t.integer  "statut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "job_users", :id => false, :force => true do |t|
    t.integer "job_id"
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "jobs", :force => true do |t|
    t.string   "label"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_users", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.boolean "admin"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "city"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_project_file_name"
    t.string   "avatar_project_content_type"
    t.integer  "avatar_project_file_size"
    t.datetime "avatar_project_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "location"
    t.string   "status"
    t.string   "links"
    t.string   "url_img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "yt_video_id"
    t.boolean  "is_complete", :default => false
    t.integer  "parent_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
