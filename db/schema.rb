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

ActiveRecord::Schema.define(version: 20161015102422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"

  create_table "cancers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "shout_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shout_id"], name: "index_comments_on_shout_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "diagnoses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cancer_id"
    t.datetime "diagnosed_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "stage",        default: 1, null: false
    t.index ["cancer_id"], name: "index_diagnoses_on_cancer_id", using: :btree
    t.index ["user_id"], name: "index_diagnoses_on_user_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "sender_id",   null: false
    t.integer  "receiver_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shouts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shouts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string    "handle",                                                                                          null: false
    t.integer   "gender",                                                                                          null: false
    t.string    "email",                                                                                           null: false
    t.datetime  "created_at",                                                                                      null: false
    t.datetime  "updated_at",                                                                                      null: false
    t.string    "encrypted_password",                                                              default: "",    null: false
    t.string    "reset_password_token"
    t.datetime  "reset_password_sent_at"
    t.datetime  "remember_created_at"
    t.integer   "sign_in_count",                                                                   default: 0,     null: false
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.inet      "current_sign_in_ip"
    t.inet      "last_sign_in_ip"
    t.integer   "failed_attempts",                                                                 default: 0,     null: false
    t.string    "unlock_token"
    t.datetime  "locked_at"
    t.integer   "authority",                                                                       default: 0,     null: false
    t.boolean   "invisible",                                                                       default: false, null: false
    t.datetime  "birthdate"
    t.geography "location",               limit: {:srid=>4326, :type=>"point", :geographic=>true},                 null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "shouts", on_delete: :cascade
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "shouts", "users"
end
