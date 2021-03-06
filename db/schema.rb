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

ActiveRecord::Schema.define(version: 20151210173815) do

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "can_start"
    t.boolean  "can_stop"
  end

  add_index "authorizations", ["game_id"], name: "index_authorizations_on_game_id"
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id"

  create_table "game_caches", force: :cascade do |t|
    t.integer  "game_id"
    t.text     "status"
    t.boolean  "invalidated"
    t.datetime "created_at"
  end

  add_index "game_caches", ["created_at"], name: "index_game_caches_on_created_at"
  add_index "game_caches", ["game_id"], name: "index_game_caches_on_game_id"

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "icon"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "service_name"
  end

  add_index "games", ["short_name"], name: "index_games_on_short_name"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["username"], name: "index_users_on_username"

end
