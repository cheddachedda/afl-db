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

ActiveRecord::Schema.define(version: 2021_10_27_054918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
  end

  create_table "clubs_fixtures", id: false, force: :cascade do |t|
    t.integer "club_id"
    t.integer "fixture_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "round_id"
    t.datetime "datetime"
    t.string "venue"
    t.integer "home_id"
    t.integer "home_score"
    t.integer "away_id"
    t.integer "away_score"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "club_id"
    t.string "position", default: [], array: true
    t.integer "fantasy_scores", default: [], array: true
  end

end
