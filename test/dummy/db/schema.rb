# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2014_07_30_143530) do

  create_table "dovecote_messages", force: :cascade do |t|
    t.string "body"
    t.string "originator", null: false
    t.string "msisdn", null: false
    t.string "reference"
    t.string "bird_id", null: false
    t.string "status", null: false
    t.datetime "scheduled_at"
    t.datetime "sent_at"
    t.datetime "buffered_at"
    t.datetime "delivered_at"
    t.datetime "expired_at"
    t.datetime "delivery_failed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
