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

ActiveRecord::Schema[8.1].define(version: 2026_03_09_123236) do
  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "loser_id", null: false
    t.datetime "updated_at", null: false
    t.integer "winner_id", null: false
    t.index ["loser_id"], name: "index_matches_on_loser_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "losses", default: 0
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "wins", default: 0
  end

  add_foreign_key "matches", "players", column: "loser_id"
  add_foreign_key "matches", "players", column: "winner_id"
end
