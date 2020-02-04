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

ActiveRecord::Schema.define(version: 2020_01_30_054509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "device_options", force: :cascade do |t|
    t.integer "option_id"
    t.integer "device_id"
    t.index ["device_id"], name: "index_device_options_on_device_id"
    t.index ["option_id", "device_id"], name: "index_device_options_on_option_id_and_device_id", unique: true
    t.index ["option_id"], name: "index_device_options_on_option_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_token"
  end

  create_table "experiments", force: :cascade do |t|
    t.string "name"
  end

  create_table "options", force: :cascade do |t|
    t.integer "experiment_id"
    t.decimal "percent", precision: 2
    t.string "value"
    t.index ["experiment_id"], name: "index_options_on_experiment_id"
  end

end
