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

ActiveRecord::Schema.define(version: 20140619033513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: true do |t|
    t.string   "website"
    t.string   "location"
    t.integer  "School_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "school_id"
  end

  add_index "classrooms", ["School_id"], name: "index_classrooms_on_School_id", using: :btree
  add_index "classrooms", ["school_id"], name: "index_classrooms_on_school_id", using: :btree

  create_table "classrooms_educators", force: true do |t|
    t.integer "classroom_id"
    t.integer "educator_id"
  end

  add_index "classrooms_educators", ["classroom_id"], name: "index_classrooms_educators_on_classroom_id", using: :btree
  add_index "classrooms_educators", ["educator_id"], name: "index_classrooms_educators_on_educator_id", using: :btree

  create_table "classrooms_schools", force: true do |t|
    t.integer "classroom_id"
    t.integer "school_id"
  end

  add_index "classrooms_schools", ["classroom_id"], name: "index_classrooms_schools_on_classroom_id", using: :btree
  add_index "classrooms_schools", ["school_id"], name: "index_classrooms_schools_on_school_id", using: :btree

  create_table "educators", force: true do |t|
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "educators", ["user_id"], name: "index_educators_on_user_id", using: :btree

  create_table "educators_school_districts", force: true do |t|
    t.integer "educator_id"
    t.integer "SchoolDistrict_id"
  end

  add_index "educators_school_districts", ["SchoolDistrict_id"], name: "index_educators_school_districts_on_SchoolDistrict_id", using: :btree
  add_index "educators_school_districts", ["educator_id"], name: "index_educators_school_districts_on_educator_id", using: :btree

  create_table "educators_schools", force: true do |t|
    t.integer "educator_id"
    t.integer "school_id"
  end

  add_index "educators_schools", ["educator_id"], name: "index_educators_schools_on_educator_id", using: :btree
  add_index "educators_schools", ["school_id"], name: "index_educators_schools_on_school_id", using: :btree

  create_table "experts", force: true do |t|
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "experts", ["user_id"], name: "index_experts_on_user_id", using: :btree

  create_table "school_districts", force: true do |t|
    t.string   "website"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "school_districts_schools", force: true do |t|
    t.integer "SchoolDistrict_id"
    t.integer "school_id"
  end

  add_index "school_districts_schools", ["SchoolDistrict_id"], name: "index_school_districts_schools_on_SchoolDistrict_id", using: :btree
  add_index "school_districts_schools", ["school_id"], name: "index_school_districts_schools_on_school_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "website"
    t.string   "location"
    t.integer  "SchoolDistrict_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_district_id"
    t.string   "name"
  end

  add_index "schools", ["SchoolDistrict_id"], name: "index_schools_on_SchoolDistrict_id", using: :btree
  add_index "schools", ["school_district_id"], name: "index_schools_on_school_district_id", using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
