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

ActiveRecord::Schema.define(version: 2021_10_27_054929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.text "logo"
    t.string "website"
    t.string "fixtures_alias"
    t.string "afl_tables_alias"
  end

  create_table "clubs_fixtures", id: false, force: :cascade do |t|
    t.integer "club_id"
    t.integer "fixture_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "round_id"
    t.string "round"
    t.datetime "datetime"
    t.string "venue"
    t.integer "home_id"
    t.integer "away_id"
    t.integer "home_score"
    t.integer "away_score"
  end

  create_table "fixtures_players", id: false, force: :cascade do |t|
    t.integer "fixture_id"
    t.integer "player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.integer "club_id"
    t.integer "jersey"
    t.string "position", default: [], array: true
    t.integer "fantasy_scores", default: [], array: true
    t.integer "games_played"
    t.float "average_fantasy_score"
    t.integer "kicks", default: [], array: true
    t.integer "marks", default: [], array: true
    t.integer "handballs", default: [], array: true
    t.integer "disposals", default: [], array: true
    t.integer "goals", default: [], array: true
    t.integer "behinds", default: [], array: true
    t.integer "hit_outs", default: [], array: true
    t.integer "tackles", default: [], array: true
    t.integer "rebound_50s", default: [], array: true
    t.integer "inside_50s", default: [], array: true
    t.integer "clearances", default: [], array: true
    t.integer "clangers", default: [], array: true
    t.integer "free_kicks_for", default: [], array: true
    t.integer "free_kicks_against", default: [], array: true
    t.integer "brownlow_votes", default: [], array: true
    t.integer "contested_possessions", default: [], array: true
    t.integer "uncontested_possessions", default: [], array: true
    t.integer "contested_marks", default: [], array: true
    t.integer "marks_inside_50", default: [], array: true
    t.integer "one_percenters", default: [], array: true
    t.integer "bounces", default: [], array: true
    t.integer "goal_assists", default: [], array: true
    t.integer "percentage_time_on_ground", default: [], array: true
    t.string "expected_dtlive_alias"
  end

end
