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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141226161523) do

  create_table "admin_accounts", force: true do |t|
    t.string   "username"
    t.string   "password_sha1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendee_applications", force: true do |t|
    t.integer  "event_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "female"
    t.text     "application_text"
    t.text     "prior_experience"
    t.text     "other_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           default: 0
    t.string   "token"
    t.integer  "age"
    t.boolean  "mailinglist_subscription", default: false
  end

  create_table "coach_applications", force: true do |t|
    t.integer  "event_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "other_text"
    t.string   "token"
    t.integer  "status",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "coachdinner", default: false
    t.boolean  "mailinglist_subscription", default: false
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.date     "event_date"
    t.date     "coach_reg_start"
    t.date     "coach_reg_end"
    t.date     "attendee_reg_start"
    t.date     "attendee_reg_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "coach_dinner_date"
  end

end
