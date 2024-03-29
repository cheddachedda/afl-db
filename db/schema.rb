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

ActiveRecord::Schema.define(version: 2021_11_21_075306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "moniker"
    t.string "abbreviation"
  end

  create_table "clubs_fixtures", id: false, force: :cascade do |t|
    t.integer "club_id"
    t.integer "fixture_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "round_no"
    t.datetime "datetime"
    t.string "venue"
    t.integer "home_id"
    t.integer "away_id"
    t.integer "home_goals_qt"
    t.integer "home_behinds_qt"
    t.integer "home_goals_ht"
    t.integer "home_behinds_ht"
    t.integer "home_goals_3qt"
    t.integer "home_behinds_3qt"
    t.integer "home_goals_ft"
    t.integer "home_behinds_ft"
    t.integer "away_goals_qt"
    t.integer "away_behinds_qt"
    t.integer "away_goals_ht"
    t.integer "away_behinds_ht"
    t.integer "away_goals_3qt"
    t.integer "away_behinds_3qt"
    t.integer "away_goals_ft"
    t.integer "away_behinds_ft"
  end

  create_table "game_logs", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "fixture_id"
    t.bigint "club_id"
    t.integer "kicks"
    t.integer "marks"
    t.integer "handballs"
    t.integer "goals"
    t.integer "behinds"
    t.integer "hit_outs"
    t.integer "tackles"
    t.integer "free_kicks_for"
    t.integer "free_kicks_against"
    t.integer "percentage_time_on_ground"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_id"], name: "index_game_logs_on_club_id"
    t.index ["fixture_id"], name: "index_game_logs_on_fixture_id"
    t.index ["player_id"], name: "index_game_logs_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_initial"
    t.string "last_name"
    t.bigint "club_id"
    t.string "position", default: [], array: true
    t.index ["club_id"], name: "index_players_on_club_id"
  end

end
