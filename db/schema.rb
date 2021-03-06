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

ActiveRecord::Schema.define(version: 20180310074023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_statistics", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "url"
    t.datetime "access_date"
    t.index ["email"], name: "user_statistics_email_idx"
  end

  create_table "users", primary_key: "email", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "address"
  end

end
