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

ActiveRecord::Schema.define(version: 20140730143530) do

  create_table "dovecote_messages", force: true do |t|
    t.string   "body"
    t.string   "originator",         null: false
    t.string   "recipient",          null: false
    t.string   "reference"
    t.string   "bird_id",            null: false
    t.string   "status",             null: false
    t.datetime "scheduled_at"
    t.datetime "datetime"
    t.datetime "sent_at"
    t.datetime "buffered_at"
    t.datetime "delivered_at"
    t.datetime "delivery_failed_at"
  end

end