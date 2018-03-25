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

ActiveRecord::Schema.define(version: 20180325174405) do

  create_table "areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "postal_code",                                         null: false
    t.integer  "prefectural_id"
    t.string   "city",                                   default: ""
    t.string   "street",                                 default: ""
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.decimal  "lat",            precision: 9, scale: 6
    t.decimal  "lng",            precision: 9, scale: 6
    t.index ["postal_code"], name: "index_areas_on_postal_code", using: :btree
    t.index ["prefectural_id"], name: "index_areas_on_prefectural_id", using: :btree
  end

  create_table "bank_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "bank",            default: "", null: false
    t.integer  "account_type",    default: 0,  null: false
    t.string   "branch_code",     default: "", null: false
    t.string   "account_number",  default: "", null: false
    t.string   "name",            default: "", null: false
    t.integer  "seller_id",                    null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "bank_code"
    t.string   "bank_account_id"
    t.string   "string"
    t.index ["seller_id"], name: "index_bank_accounts_on_seller_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "share_id"
    t.integer  "order_id"
    t.integer  "unit_price"
    t.integer  "quantity"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id", using: :btree
    t.index ["share_id"], name: "index_order_details_on_share_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "seller_id"
    t.integer  "total_price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "summed_price"
    t.index ["seller_id"], name: "index_orders_on_seller_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "prefecturals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sellers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "self_introduction",   limit: 65535
    t.string   "photo"
    t.string   "sns_info"
    t.string   "stripe_account_id"
    t.string   "postal_code"
    t.string   "address_kana_state"
    t.string   "address_kana_city"
    t.string   "address_kana_town"
    t.string   "address_kana_line"
    t.string   "address_kanji_state"
    t.string   "address_kanji_city"
    t.string   "address_kanji_town"
    t.string   "address_kanji_line"
    t.date     "date_of_birth"
    t.string   "first_name_kana"
    t.string   "last_name_kana"
    t.string   "first_name_kanji"
    t.string   "last_name_kanji"
    t.string   "phone_number"
    t.integer  "gender"
    t.index ["user_id"], name: "index_sellers_on_user_id", using: :btree
  end

  create_table "shares", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "menu",                     null: false
    t.integer  "price",                    null: false
    t.integer  "quantity",                 null: false
    t.integer  "ticket_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "image"
    t.text     "message",    limit: 65535
    t.index ["ticket_id"], name: "index_shares_on_ticket_id", using: :btree
  end

  create_table "talks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "message",    limit: 65535, null: false
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["group_id"], name: "index_talks_on_group_id", using: :btree
    t.index ["user_id"], name: "index_talks_on_user_id", using: :btree
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "event_date",      null: false
    t.datetime "expiration_date", null: false
    t.string   "event_place",     null: false
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "genre"
    t.datetime "event_end_date"
    t.index ["buyer_id"], name: "index_tickets_on_buyer_id", using: :btree
    t.index ["seller_id"], name: "index_tickets_on_seller_id", using: :btree
  end

  create_table "user_areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id", using: :btree
    t.index ["user_id"], name: "index_user_groups_on_user_id", using: :btree
  end

  create_table "user_invitation_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_user_invitation_codes_on_code", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_invitation_codes_on_user_id", using: :btree
  end

  create_table "user_point_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                  null: false
    t.integer  "amount",                   null: false
    t.integer  "reason_id",                null: false
    t.text     "detail",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_user_point_logs_on_user_id", using: :btree
  end

  create_table "user_points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id",             null: false
    t.integer "amount",  default: 0, null: false
    t.index ["user_id"], name: "index_user_points_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "remember_digest"
    t.string   "image"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "accepted"
    t.string   "stripe_customer_id"
    t.boolean  "use_invitation_code", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "bank_accounts", "sellers"
  add_foreign_key "user_invitation_codes", "users"
  add_foreign_key "user_point_logs", "users"
  add_foreign_key "user_points", "users"
end
