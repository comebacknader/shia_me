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

ActiveRecord::Schema.define(:version => 20121230193225) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.text     "bio"
    t.string   "location"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "ethnicity"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["remember_token"], :name => "index_admins_on_remember_token"

  create_table "feeds", :force => true do |t|
    t.string   "title"
    t.text     "post"
    t.integer  "feedable_id"
    t.string   "feedable_type"
    t.integer  "admin_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "invites", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "man_id"
    t.integer  "woman_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "reason"
    t.boolean  "femapprove"
    t.boolean  "infoapprove"
    t.boolean  "picapprove"
    t.integer  "admin_id"
    t.string   "femreason"
  end

  add_index "matches", ["man_id", "woman_id"], :name => "index_matches_on_man_id_and_woman_id", :unique => true
  add_index "matches", ["man_id"], :name => "index_matches_on_man_id"
  add_index "matches", ["woman_id"], :name => "index_matches_on_woman_id"

  create_table "messages", :force => true do |t|
    t.text     "message"
    t.integer  "sender_id"
    t.integer  "reciever_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "seen"
  end

  create_table "mquests", :force => true do |t|
    t.string   "agerange"
    t.string   "edulevel"
    t.string   "ethnic"
    t.string   "needhijabi"
    t.text     "anypref"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "msgs", :force => true do |t|
    t.integer  "admin_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "message"
    t.boolean  "seen"
    t.boolean  "user_hide"
    t.boolean  "admin_hide"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "education"
    t.string   "job"
    t.string   "syed"
    t.string   "prayer"
    t.string   "hijab"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "ethnicity"
    t.string   "firsthobby"
    t.string   "secondhobby"
    t.string   "thirdhobby"
    t.string   "islamtoyou"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subscribers", ["email"], :name => "index_subscribers_on_email", :unique => true

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.integer  "plan_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "bio"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "email"
    t.string   "gender"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "admin_id"
    t.integer  "age"
    t.string   "permission"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
