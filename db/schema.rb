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

ActiveRecord::Schema.define(version: 20170831050755) do

  create_table "cabinet_apli_scis", force: :cascade do |t|
    t.integer "user_id"
    t.string "cabins_aplsci"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cabinet_apli_scis_on_user_id"
  end

  create_table "cabinet_imes", force: :cascade do |t|
    t.integer "user_id"
    t.string "cabins_ime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cabinet_imes_on_user_id"
  end

  create_table "cabinets", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cabins"
    t.string "major"
    t.string "cabin"
    t.index ["user_id"], name: "index_cabinets_on_user_id"
  end

  create_table "limits", force: :cascade do |t|
    t.string "student_time"
    t.string "gda_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "student_time_"
    t.string "gda_time_"
  end

  create_table "tempusers", force: :cascade do |t|
    t.string "name"
    t.string "stuN"
    t.string "major"
    t.string "identity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "feeOfSch"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "seatNumber"
    t.string "identity", default: "1"
    t.string "major"
    t.string "stuN"
    t.boolean "applied_sci_admin", default: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stuN"], name: "index_users_on_stuN", unique: true
  end

end
