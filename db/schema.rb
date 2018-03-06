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

ActiveRecord::Schema.define(version: 20180306021928) do

  create_table "lookups", force: :cascade do |t|
    t.string   "external_id"
    t.date     "start"
    t.date     "finish"
    t.string   "result",      default: "Working"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "scraps", force: :cascade do |t|
    t.date     "start"
    t.date     "finish"
    t.string   "external_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "result",         default: "Working on it"
    t.date     "initial_finish"
    t.date     "last_start"
    t.integer  "total"
    t.integer  "search_id"
  end

  add_index "scraps", ["search_id"], name: "index_scraps_on_search_id"

  create_table "searches", force: :cascade do |t|
    t.string   "external_id"
    t.date     "start"
    t.date     "finish"
    t.string   "result",      default: "Working"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
