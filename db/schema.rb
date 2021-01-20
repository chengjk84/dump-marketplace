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

ActiveRecord::Schema.define(version: 26) do

  create_table "banks", force: :cascade do |t|
    t.integer  "business_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "referrer_id"
    t.string   "name"
    t.string   "uuid"
    t.string   "qr_code"
    t.string   "email"
    t.string   "email_verification_token"
    t.boolean  "verified_email",            default: false, null: false
    t.string   "mobile"
    t.string   "mobile_verification_token"
    t.boolean  "verified_mobile",           default: false, null: false
    t.string   "bank_name"
    t.string   "bank_account_no"
    t.boolean  "verified_bank_account"
    t.string   "phone"
    t.string   "fax"
    t.string   "certificate_id"
    t.string   "certificate_photo"
    t.boolean  "verified",                  default: false, null: false
    t.string   "gst_no"
    t.string   "gst_certification_photo"
    t.boolean  "gst_verified",              default: false, null: false
    t.string   "logo"
    t.string   "banner"
    t.text     "about"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "postcode"
    t.string   "state"
    t.string   "country"
    t.float    "lng"
    t.float    "lat"
    t.integer  "type_id"
    t.integer  "list_id"
    t.boolean  "active",                    default: true,  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "bank_account_name"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "parent_id"
    t.string  "name"
    t.string  "slug"
  end

  create_table "collections", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "business_id"
    t.boolean  "person_response"
    t.boolean  "business_response"
    t.boolean  "active",            default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "collection_id"
    t.integer  "product_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.string "slug"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.decimal  "unit_price",  precision: 15, scale: 2
    t.decimal  "unit_ship",   precision: 15, scale: 2
    t.integer  "quantity"
    t.decimal  "total_price", precision: 15, scale: 2, default: "0.0"
    t.decimal  "total_ship",  precision: 15, scale: 2, default: "0.0"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "journals", force: :cascade do |t|
    t.string   "name"
    t.string   "remark"
    t.string   "ref_no"
    t.decimal  "debitt",     precision: 15, scale: 2
    t.decimal  "credit",     precision: 15, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "slug"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "conversation_id"
    t.string   "remark"
    t.text     "content"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "qr_code"
    t.string   "uuid"
    t.integer  "person_id"
    t.integer  "business_id"
    t.string   "shipment_service"
    t.string   "shipment_tracking_no"
    t.string   "shipment_checking_url"
    t.decimal  "subtotal",              precision: 15, scale: 2, default: "0.0"
    t.decimal  "shipment",              precision: 15, scale: 2, default: "0.0"
    t.decimal  "total",                 precision: 15, scale: 2, default: "0.0"
    t.boolean  "to_redeem_at_store"
    t.datetime "ordered_at"
    t.datetime "paid_at"
    t.datetime "shipped_at"
    t.datetime "completed_at"
    t.datetime "returned_at"
    t.datetime "complain_at"
    t.integer  "status_id"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer  "sponsor_id"
    t.integer  "role_id",                   default: 1
    t.string   "sponsor_token"
    t.string   "qr_code"
    t.string   "uuid"
    t.string   "password_digest"
    t.string   "email"
    t.string   "email_verification_token"
    t.boolean  "verified_email",            default: false, null: false
    t.string   "mobile"
    t.string   "mobile_verification_token"
    t.boolean  "verified_mobile",           default: false, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender_id",                 default: 1,     null: false
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "postcode"
    t.string   "state"
    t.string   "country"
    t.string   "identification"
    t.string   "identification_photo"
    t.boolean  "verified_identification",   default: false, null: false
    t.string   "bank_name"
    t.string   "bank_account_no"
    t.string   "bank_account_name"
    t.string   "avatar"
    t.boolean  "active",                    default: true,  null: false
    t.boolean  "master",                    default: false, null: false
    t.boolean  "admin",                     default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["gender_id"], name: "index_people_on_gender_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.decimal "price"
    t.integer "level"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "category_id"
    t.string   "name"
    t.string   "qr_code"
    t.string   "uuid"
    t.text     "description"
    t.decimal  "price",                     precision: 15, scale: 2
    t.decimal  "promotion",                 precision: 15, scale: 2
    t.integer  "stock_in_hand",                                      default: 0
    t.decimal  "shipment_peninsular",       precision: 15, scale: 2, default: "0.0"
    t.decimal  "shipment_sabah_and_labuan", precision: 15, scale: 2, default: "0.0"
    t.decimal  "shipment_sarawak",          precision: 15, scale: 2, default: "0.0"
    t.string   "image_01"
    t.string   "image_02"
    t.string   "image_03"
    t.string   "image_04"
    t.string   "image_05"
    t.boolean  "featured"
    t.boolean  "active",                                             default: true,  null: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "product"
    t.integer  "person"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.integer  "bank_id"
    t.string   "description"
    t.string   "ref_no"
    t.decimal  "debit",       precision: 15, scale: 2
    t.decimal  "credit",      precision: 15, scale: 2
    t.string   "status"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "plan_id"
    t.string   "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "wallet_id"
    t.string   "description"
    t.string   "ref_no"
    t.decimal  "debit",       precision: 15, scale: 2
    t.decimal  "credit",      precision: 15, scale: 2
    t.string   "status"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.string "slug"
  end

  create_table "wallets", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
