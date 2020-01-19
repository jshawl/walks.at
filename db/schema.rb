# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_18_201020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.datetime "created_at"
    t.float "latitude"
    t.float "longitude"
    t.integer "speed"
    t.integer "direction"
    t.integer "accuracy"
  end

  create_table "places", force: :cascade do |t|
    t.datetime "created_at"
    t.float "latitude"
    t.float "longitude"
    t.string "name"
  end

end
