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

ActiveRecord::Schema.define(version: 20150926194814) do

  create_table "projects", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "title_slug",        limit: 255
    t.integer  "user_id",           limit: 4
    t.boolean  "show_in_dashboard"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "completed_at"
    t.integer  "worked_time_minutes", limit: 4
    t.integer  "worked_time_seconds", limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "project_id",          limit: 4
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "email",              limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "salt",               limit: 255
    t.boolean  "is_admin"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "tasks", "projects"
end
