# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2020_03_13_064805) do
  create_table "follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["user_id", "followee_id"], name: "index_follows_on_user_id_and_followee_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "tweets"
    t.text "all_search_result_tweets"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "edit_mode"
  end

  create_table "search_settings", force: :cascade do |t|
    t.integer "note_id"
    t.string "query"
    t.string "start_datetime"
    t.string "end_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_search_settings_on_note_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "followee_id"
  add_foreign_key "search_settings", "notes"
end
