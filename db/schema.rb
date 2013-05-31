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

ActiveRecord::Schema.define(:version => 20130531005240) do

  create_table "case_entries", :force => true do |t|
    t.date     "entry_date"
    t.text     "work_particulars"
    t.integer  "client_id"
    t.integer  "file_matter_id"
    t.string   "time_spent_from"
    t.string   "time_spent_to"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "file_matter_case"
    t.integer  "lawyer_id"
    t.string   "case_title"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "contact_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "position"
    t.text     "address"
    t.string   "contact_person"
  end

  create_table "file_matters", :force => true do |t|
    t.string   "year"
    t.string   "file_code"
    t.string   "volume"
    t.string   "client_id"
    t.string   "title"
    t.string   "case_number"
    t.string   "lawyer_id"
    t.string   "case_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lawyers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "mobile_number"
    t.string   "position"
    t.string   "email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "rate"
    t.string   "initials"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "username"
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
