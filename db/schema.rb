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

ActiveRecord::Schema.define(version: 20170301101321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_availabilities_on_game_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "category"
    t.integer  "average_duration"
    t.integer  "min_number_players"
    t.string   "age_range"
    t.float    "price"
    t.integer  "profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "max_number_players"
    t.index ["profile_id"], name: "index_games_on_profile_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "days"
    t.string   "status"
    t.float    "total_price"
    t.integer  "game_id"
    t.integer  "profile_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["game_id"], name: "index_orders_on_game_id", using: :btree
    t.index ["profile_id"], name: "index_orders_on_profile_id", using: :btree
  end

  create_table "owner_reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.string   "state"
    t.integer  "profile_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_owner_reviews_on_order_id", using: :btree
    t.index ["profile_id"], name: "index_owner_reviews_on_profile_id", using: :btree
  end

  create_table "player_reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.string   "state"
    t.integer  "profile_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_player_reviews_on_order_id", using: :btree
    t.index ["profile_id"], name: "index_player_reviews_on_profile_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "phone_number"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "latitude"
    t.float    "longitude"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "availabilities", "games"
  add_foreign_key "games", "profiles"
  add_foreign_key "orders", "games"
  add_foreign_key "orders", "profiles"
  add_foreign_key "owner_reviews", "orders"
  add_foreign_key "owner_reviews", "profiles"
  add_foreign_key "player_reviews", "orders"
  add_foreign_key "player_reviews", "profiles"
  add_foreign_key "profiles", "users"
end
