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

ActiveRecord::Schema.define(version: 20140807030756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: true do |t|
    t.string   "website"
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "school_id"
    t.integer  "grade"
    t.integer  "grade_level_id"
  end

  add_index "classrooms", ["grade_level_id"], name: "index_classrooms_on_grade_level_id", using: :btree
  add_index "classrooms", ["school_id"], name: "index_classrooms_on_school_id", using: :btree

  create_table "classrooms_schools", force: true do |t|
    t.integer "classroom_id"
    t.integer "school_id"
  end

  add_index "classrooms_schools", ["classroom_id"], name: "index_classrooms_schools_on_classroom_id", using: :btree
  add_index "classrooms_schools", ["school_id"], name: "index_classrooms_schools_on_school_id", using: :btree

  create_table "companies", force: true do |t|
    t.text     "name"
    t.text     "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educator_staffings", force: true do |t|
    t.integer  "staffable_id"
    t.integer  "educator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "staffable_type"
  end

  add_index "educator_staffings", ["educator_id"], name: "index_educator_staffings_on_educator_id", using: :btree
  add_index "educator_staffings", ["staffable_id"], name: "index_educator_staffings_on_staffable_id", using: :btree

  create_table "educators", force: true do |t|
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "educators", ["user_id"], name: "index_educators_on_user_id", using: :btree

  create_table "employment_links", force: true do |t|
    t.integer  "expert_id",  null: false
    t.integer  "company_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employment_links", ["company_id", "expert_id"], name: "index_employment_links_on_company_id_and_expert_id", using: :btree
  add_index "employment_links", ["expert_id", "company_id"], name: "index_employment_links_on_expert_id_and_company_id", using: :btree

  create_table "experts", force: true do |t|
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "experts", ["user_id"], name: "index_experts_on_user_id", using: :btree

  create_table "grade_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledge_links", force: true do |t|
    t.integer  "knowledgeable_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "knowledgeable_type"
  end

  add_index "knowledge_links", ["knowledgeable_id"], name: "index_knowledge_links_on_knowledgeable_id", using: :btree
  add_index "knowledge_links", ["subject_id"], name: "index_knowledge_links_on_subject_id", using: :btree

  create_table "school_districts", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "website"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "school_district_id"
  end

  add_index "schools", ["school_district_id"], name: "index_schools_on_school_district_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
