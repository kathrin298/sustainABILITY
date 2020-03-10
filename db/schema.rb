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

ActiveRecord::Schema.define(version: 2020_03_10_043841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.bigint "question_id"
    t.bigint "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_answers_on_application_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "applications", force: :cascade do |t|
    t.bigint "developer_id"
    t.bigint "job_id"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_applications_on_developer_id"
    t.index ["job_id"], name: "index_applications_on_job_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.bigint "user_id"
    t.text "mission"
    t.integer "employees"
    t.string "industry"
    t.text "bio"
    t.string "website"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "developer_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "developer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_developer_skills_on_developer_id"
    t.index ["skill_id"], name: "index_developer_skills_on_skill_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.text "bio"
    t.text "slogan"
    t.text "interests"
    t.string "hireable"
    t.text "websites", default: [], array: true
    t.text "social_links", default: [], array: true
    t.bigint "user_id"
    t.string "github_profile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_developers_on_user_id"
  end

  create_table "job_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_skills_on_job_id"
    t.index ["skill_id"], name: "index_job_skills_on_skill_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_title"
    t.text "job_description"
    t.boolean "active"
    t.bigint "company_id"
    t.string "location"
    t.boolean "remote"
    t.string "start_date"
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_questions_on_job_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "applications"
  add_foreign_key "answers", "questions"
  add_foreign_key "applications", "developers"
  add_foreign_key "applications", "jobs"
  add_foreign_key "companies", "users"
  add_foreign_key "developer_skills", "developers"
  add_foreign_key "developer_skills", "skills"
  add_foreign_key "developers", "users"
  add_foreign_key "job_skills", "jobs"
  add_foreign_key "job_skills", "skills"
  add_foreign_key "jobs", "companies"
  add_foreign_key "questions", "jobs"
end
