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

ActiveRecord::Schema.define(version: 20170217124342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_recipes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cart_recipes", ["recipe_id"], name: "index_cart_recipes_on_recipe_id", using: :btree
  add_index "cart_recipes", ["user_id"], name: "index_cart_recipes_on_user_id", using: :btree

  create_table "customer_addresses", force: :cascade do |t|
    t.text     "address"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "customer_addresses", ["customer_id"], name: "index_customer_addresses_on_customer_id", using: :btree

  create_table "customer_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "customer_users", ["customer_id"], name: "index_customer_users_on_customer_id", using: :btree
  add_index "customer_users", ["user_id"], name: "index_customer_users_on_user_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
  end

  create_table "notes_orders", force: :cascade do |t|
    t.string   "description"
    t.integer  "order_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "notes_orders", ["order_id"], name: "index_notes_orders_on_order_id", using: :btree

  create_table "order_recipes", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_recipes", ["order_id"], name: "index_order_recipes_on_order_id", using: :btree
  add_index "order_recipes", ["recipe_id"], name: "index_order_recipes_on_recipe_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.integer  "customer_address_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "amount"
    t.string   "mode_of_payment"
    t.string   "delivery_time"
    t.string   "o_id"
    t.boolean  "preorder",            default: false
  end

  add_index "orders", ["customer_address_id"], name: "index_orders_on_customer_address_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "sku"
    t.string   "name"
    t.integer  "serving"
    t.integer  "price"
    t.boolean  "non_veg"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "availability", default: false
    t.string   "cusine"
  end

  create_table "stats", force: :cascade do |t|
    t.boolean  "shop_open",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "discount"
  end

  create_table "users", force: :cascade do |t|
    t.string   "merchant_pin",           default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "full_name"
    t.text     "address"
    t.boolean  "non_veg",                default: true
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.text     "phone"
  end

  add_index "users", ["merchant_pin"], name: "index_users_on_merchant_pin", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
