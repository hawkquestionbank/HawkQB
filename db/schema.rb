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

ActiveRecord::Schema.define(version: 2020_01_10_221708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "txt"
    t.boolean "is_correct", default: false
    t.integer "question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.text "txt"
    t.bigint "question_id"
    t.bigint "user_id"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "answer_hash", default: {}
    t.decimal "score"
    t.index ["answer_id"], name: "index_attempts_on_answer_id"
    t.index ["question_id"], name: "index_attempts_on_question_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "course_registrations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_registrations_on_course_id"
    t.index ["user_id"], name: "index_course_registrations_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_user_id"
    t.string "token"
    t.integer "max_attempts", default: 2
    t.datetime "close_to_attempts"
    t.datetime "can_view_answers_after"
    t.boolean "is_an_exam", default: false
    t.integer "default_number_of_choices", default: 4
    t.datetime "hide_from_students_after"
  end

  create_table "micro_credential_maps", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "micro_credential_id"
    t.index ["course_id"], name: "index_micro_credential_maps_on_course_id"
    t.index ["micro_credential_id"], name: "index_micro_credential_maps_on_micro_credential_id"
  end

  create_table "micro_credentials", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "creator_user_id"
    t.string "identifier", limit: 20
  end

  create_table "question_micro_credentials", force: :cascade do |t|
    t.integer "question_id"
    t.integer "micro_credential_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_user_id"
    t.integer "course_id"
    t.integer "copied_from_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "roles"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "attempts", "answers"
  add_foreign_key "attempts", "questions"
  add_foreign_key "attempts", "users"
  add_foreign_key "courses", "users", column: "creator_user_id"
  add_foreign_key "micro_credentials", "users", column: "creator_user_id"
  add_foreign_key "question_micro_credentials", "micro_credentials"
  add_foreign_key "question_micro_credentials", "questions"
  add_foreign_key "questions", "courses"
  add_foreign_key "questions", "users", column: "creator_user_id"
end
