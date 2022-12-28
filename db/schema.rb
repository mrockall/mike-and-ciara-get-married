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

ActiveRecord::Schema[7.0].define(version: 2022_12_28_110258) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer "question_id"
    t.string "text"
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count_chosen", default: 0
    t.string "key"
    t.boolean "enabled"
    t.integer "position"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled"
    t.string "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.text "description"
    t.date "available_after_date"
    t.integer "position"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_id"
    t.text "text"
    t.integer "count_correct", default: 0
    t.integer "count_incorrect", default: 0
    t.string "key"
    t.boolean "enabled"
    t.string "photo"
    t.integer "position"
  end

  create_table "session_game_answers", force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_game_id"
  end

  create_table "session_games", force: :cascade do |t|
    t.string "old_string_session_id"
    t.integer "game_id"
    t.string "status"
    t.integer "count_correct"
    t.integer "count_incorrect"
    t.integer "count_remaining"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id"
    t.string "name"
    t.integer "games_played"
    t.integer "count_correct"
    t.integer "count_incorrect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
