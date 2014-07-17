# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140717002543) do

  create_table "cart_products", force: true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_products", ["cart_id", "product_id"], name: "index_cart_products_on_cart_id_and_product_id", unique: true

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "diary_id",     null: false
    t.integer  "commenter_id", null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diaries", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diary_images", force: true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "diary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name",                          null: false
    t.string   "image"
    t.integer  "price",         default: 0
    t.text     "description",                   null: false
    t.boolean  "hidden",        default: false
    t.integer  "display_order", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_products", force: true do |t|
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchase_products", ["purchase_id", "product_id"], name: "index_purchase_products_on_purchase_id_and_product_id", unique: true

  create_table "purchases", force: true do |t|
    t.integer  "user_id",                    null: false
    t.string   "ship_name",                  null: false
    t.string   "ship_address",               null: false
    t.string   "ship_zip_code",    limit: 7, null: false
    t.string   "delivery_time"
    t.date     "delivery_date"
    t.integer  "product_price"
    t.integer  "shipping_cost"
    t.integer  "cash_on_delivery"
    t.integer  "tax_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                             default: ""
    t.string   "profile_image",                    default: ""
    t.string   "ship_name"
    t.string   "ship_address",                     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ship_zip_code",          limit: 7, default: ""
    t.boolean  "admin",                            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
