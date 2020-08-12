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

ActiveRecord::Schema.define(version: 2020_08_05_061820) do

  create_table "reptiles", force: :cascade do |t|
    t.string "image"
    t.string "type1"
    t.string "type2"
    t.string "sex"
    t.string "age"
    t.string "size"
    t.string "weight"
    t.string "description"
    t.integer "price"
    t.string "sales_status"
    t.date "arrival_day"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "image"
    t.string "password"
    t.string "uid"
    t.string "token"
    t.string "provider"
    t.boolean "admin", default: false
    t.string "shop_name"
    t.string "shop_image"
    t.string "address"
    t.string "howto_access"
    t.string "tel"
    t.string "business_hours"
    t.string "holiday"
    t.string "url"
    t.string "handling_animals"
    t.string "handling_feeds"
    t.string "handling_goods"
    t.string "feature"
    t.string "map_info"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
