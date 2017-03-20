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

ActiveRecord::Schema.define(version: 20170320052421) do

  create_table "cart_recipes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "recipe_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "cart_recipes", ["recipe_id"], name: "index_cart_recipes_on_recipe_id", using: :btree
  add_index "cart_recipes", ["user_id"], name: "index_cart_recipes_on_user_id", using: :btree

  create_table "customer_addresses", force: :cascade do |t|
    t.text     "address",     limit: 65535
    t.integer  "customer_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "customer_addresses", ["customer_id"], name: "index_customer_addresses_on_customer_id", using: :btree

  create_table "customer_users", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "customer_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "customer_users", ["customer_id"], name: "index_customer_users_on_customer_id", using: :btree
  add_index "customer_users", ["user_id"], name: "index_customer_users_on_user_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "phone",      limit: 255
  end

  create_table "merchant_informations", force: :cascade do |t|
    t.string   "full_name",   limit: 255
    t.text     "address",     limit: 65535
    t.string   "phone",       limit: 255
    t.boolean  "non_veg",                   default: true
    t.boolean  "is_accepted",               default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "notes_orders", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "order_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "notes_orders", ["order_id"], name: "index_notes_orders_on_order_id", using: :btree

  create_table "order_recipes", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "recipe_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "order_recipes", ["order_id"], name: "index_order_recipes_on_order_id", using: :btree
  add_index "order_recipes", ["recipe_id"], name: "index_order_recipes_on_recipe_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "customer_id",         limit: 4
    t.integer  "customer_address_id", limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "amount",              limit: 4
    t.string   "mode_of_payment",     limit: 255
    t.string   "delivery_time",       limit: 255
    t.string   "o_id",                limit: 255
    t.boolean  "preorder",                        default: false
    t.string   "sms_status",          limit: 255, default: "default"
    t.boolean  "is_delivered"
  end

  add_index "orders", ["customer_address_id"], name: "index_orders_on_customer_address_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "sku",          limit: 255
    t.string   "name",         limit: 255
    t.integer  "serving",      limit: 4
    t.integer  "price",        limit: 4
    t.boolean  "non_veg"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "availability",             default: false
    t.string   "cusine",       limit: 255
    t.string   "ingredients",  limit: 255
  end

  create_table "sms_messages", force: :cascade do |t|
    t.string   "sms_message", limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "stats", force: :cascade do |t|
    t.boolean  "shop_open",              default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "discount",   limit: 255
    t.boolean  "sms_accept",             default: false
    t.string   "pin",        limit: 255
  end

  create_table "tests", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "merchant_pin",           limit: 255,   default: "",         null: false
    t.string   "encrypted_password",     limit: 255,   default: "",         null: false
    t.string   "full_name",              limit: 255
    t.text     "address",                limit: 65535
    t.boolean  "non_veg",                              default: true
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.text     "phone",                  limit: 65535
    t.string   "role",                   limit: 255,   default: "merchant"
    t.float    "wallet",                 limit: 24,    default: 0.0
  end

  add_index "users", ["merchant_pin"], name: "index_users_on_merchant_pin", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
