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

ActiveRecord::Schema.define(version: 2019_02_09_225009) do

  create_table "award_issuances", force: :cascade do |t|
    t.integer "bounty", default: 0, null: false
    t.integer "reason_id"
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_award_issuances_on_member_id"
    t.index ["reason_id"], name: "index_award_issuances_on_reason_id"
  end

  create_table "award_reasons", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guest_book_entries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "referral"
    t.string "misc"
  end

  create_table "members", force: :cascade do |t|
    t.string "alias"
    t.integer "kisi_actor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
