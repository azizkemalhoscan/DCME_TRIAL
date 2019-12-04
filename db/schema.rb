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

ActiveRecord::Schema.define(version: 2019_12_03_153242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["survey_id"], name: "index_participants_on_survey_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.bigint "survey_question_id"
    t.bigint "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "response"
    t.index ["participant_id"], name: "index_question_answers_on_participant_id"
    t.index ["survey_question_id"], name: "index_question_answers_on_survey_question_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.text "question"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "typeform_id"
    t.string "q_type"
    t.index ["survey_id"], name: "index_survey_questions_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "typeform_id"
    t.boolean "completed", default: false
    t.index ["project_id"], name: "index_surveys_on_project_id"
  end

  create_table "thankyou_screens", force: :cascade do |t|
    t.string "title"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_thankyou_screens_on_survey_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "welcome_messages", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "survey_id"
    t.index ["survey_id"], name: "index_welcome_messages_on_survey_id"
  end

  add_foreign_key "participants", "surveys"
  add_foreign_key "projects", "users"
  add_foreign_key "question_answers", "participants"
  add_foreign_key "question_answers", "survey_questions"
  add_foreign_key "survey_questions", "surveys"
  add_foreign_key "surveys", "projects"
  add_foreign_key "thankyou_screens", "surveys"
end
