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

ActiveRecord::Schema.define(version: 20190606211103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "employer"
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.float    "wage"
    t.datetime "expiry"
    t.string   "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "job_type_id"
  end

  add_index "jobs", ["job_type_id"], name: "index_jobs_on_job_type_id", using: :btree

  create_table "text_jobs", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "to"
    t.string   "from"
    t.string   "body"
    t.string   "url"
    t.boolean  "clicked",    default: false
  end

  add_index "text_jobs", ["job_id"], name: "index_text_jobs_on_job_id", using: :btree
  add_index "text_jobs", ["user_id"], name: "index_text_jobs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "phone"
    t.string   "first_name"
    t.boolean  "store"
    t.boolean  "coffee"
    t.boolean  "call_center"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "jobs", "job_types"
  add_foreign_key "text_jobs", "jobs"
  add_foreign_key "text_jobs", "users"
end
