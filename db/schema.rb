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

ActiveRecord::Schema.define(version: 20160928143001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "parcel_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "events", ["parcel_id"], name: "index_events_on_parcel_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "headshot_photos", force: :cascade do |t|
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.integer  "capturable_id"
    t.string   "capturable_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parcels", force: :cascade do |t|
    t.string   "sender_first_name"
    t.string   "code"
    t.integer  "owner_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "sender_last_name"
    t.string   "sender_phone"
    t.string   "receiver_first_name"
    t.string   "receiver_last_name"
    t.string   "receiver_phone"
    t.integer  "origin_id"
    t.integer  "destination_id"
  end

  add_index "parcels", ["destination_id"], name: "index_parcels_on_destination_id", using: :btree
  add_index "parcels", ["origin_id"], name: "index_parcels_on_origin_id", using: :btree
  add_index "parcels", ["owner_id"], name: "index_parcels_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "pudo",                   default: false
    t.string   "pudo_long"
    t.string   "pudo_lat"
    t.string   "pudo_city"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "events", "parcels"
  add_foreign_key "events", "users"
  add_foreign_key "parcels", "users", column: "destination_id"
  add_foreign_key "parcels", "users", column: "origin_id"
  add_foreign_key "parcels", "users", column: "owner_id"
end
