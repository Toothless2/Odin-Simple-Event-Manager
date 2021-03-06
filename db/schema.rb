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

ActiveRecord::Schema.define(version: 2020_07_12_121343) do

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "when"
    t.integer "users_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_events_on_owner_id"
    t.index ["title"], name: "index_events_on_title"
    t.index ["users_id"], name: "index_events_on_users_id"
    t.index ["when"], name: "index_events_on_when"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "users_going_to_events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_users_going_to_events_on_event_id"
    t.index ["user_id"], name: "index_users_going_to_events_on_user_id"
    t.index [nil, nil], name: "index_users_going_to_events_on_user_and_events"
  end

end
