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

ActiveRecord::Schema.define(version: 20170407013433) do

  create_table "cargo", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "safefy_rating"
    t.text     "description",   limit: 65535
    t.integer  "person_id"
    t.decimal  "weight",                      precision: 10
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["person_id"], name: "index_cargo_on_person_id", using: :btree
  end

  create_table "crew_slot_assignments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "person_id"
    t.integer  "ship_id"
    t.integer  "crew_slot_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["crew_slot_id"], name: "index_crew_slot_assignments_on_crew_slot_id", using: :btree
    t.index ["person_id"], name: "index_crew_slot_assignments_on_person_id", using: :btree
    t.index ["ship_id"], name: "index_crew_slot_assignments_on_ship_id", using: :btree
  end

  create_table "crew_slots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",  limit: 65535
    t.integer  "specialty_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["specialty_id"], name: "index_crew_slots_on_specialty_id", using: :btree
  end

  create_table "destinations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.decimal  "distance",                  precision: 10
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "ship_id"
    t.integer  "parent_terminal_id"
    t.string   "display_name"
    t.string   "slug"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["parent_terminal_id"], name: "index_facilities_on_parent_terminal_id", using: :btree
    t.index ["ship_id"], name: "index_facilities_on_ship_id", using: :btree
  end

  create_table "flight_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "trip_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_flight_logs_on_person_id", using: :btree
    t.index ["trip_id"], name: "index_flight_logs_on_trip_id", using: :btree
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "familyName"
    t.string   "givenName"
    t.string   "gender"
    t.string   "telephone"
    t.string   "email"
    t.string   "streetAddress"
    t.string   "postalCode"
    t.string   "postOfficeBoxNumber"
    t.string   "addressRegion"
    t.string   "addressLocality"
    t.string   "addressCountry"
    t.string   "homePlanet"
    t.date     "birthDate"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "people_specialties", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "person_id",    null: false
    t.integer "specialty_id", null: false
  end

  create_table "ships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "class"
    t.text     "description",        limit: 65535
    t.string   "photo_url"
    t.integer  "passenger_capacity"
    t.decimal  "base_fare",                        precision: 10
    t.integer  "shield_rating"
    t.integer  "armor_rating"
    t.decimal  "cargo_capacity",                   precision: 10
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "specialties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "trips", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "danger_rating"
    t.integer  "duration"
    t.decimal  "cost",           precision: 10
    t.string   "status"
    t.integer  "destination_id"
    t.integer  "ship_id"
    t.integer  "facility_id"
    t.datetime "departure_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["destination_id"], name: "index_trips_on_destination_id", using: :btree
    t.index ["facility_id"], name: "index_trips_on_facility_id", using: :btree
    t.index ["ship_id"], name: "index_trips_on_ship_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cargo", "people"
  add_foreign_key "crew_slot_assignments", "crew_slots"
  add_foreign_key "crew_slot_assignments", "people"
  add_foreign_key "crew_slot_assignments", "ships"
  add_foreign_key "crew_slots", "specialties"
  add_foreign_key "facilities", "facilities", column: "parent_terminal_id"
  add_foreign_key "facilities", "ships"
  add_foreign_key "flight_logs", "people"
  add_foreign_key "flight_logs", "trips"
  add_foreign_key "trips", "destinations"
  add_foreign_key "trips", "facilities"
  add_foreign_key "trips", "ships"
end
