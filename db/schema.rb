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

ActiveRecord::Schema.define(version: 2019_07_16_223335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.string "likable_type"
    t.bigint "likable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "parks", force: :cascade do |t|
    t.string "latLong"
    t.string "name"
    t.string "fullname"
    t.string "parkCode"
    t.string "states"
    t.string "designation"
    t.string "url"
    t.text "description"
    t.text "weatherInfo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.bigint "park_id"
    t.bigint "user_id"
    t.bigint "trip_id"
    t.string "url"
    t.string "title"
    t.string "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_pictures_on_park_id"
    t.index ["trip_id"], name: "index_pictures_on_trip_id"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "park_id"
    t.string "title"
    t.string "description"
    t.string "season"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_trips_on_park_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "firstname"
    t.string "lastname"
    t.string "profile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "likes", "users"
  add_foreign_key "pictures", "parks"
  add_foreign_key "pictures", "trips"
  add_foreign_key "pictures", "users"
  add_foreign_key "trips", "parks"
  add_foreign_key "trips", "users"
end
