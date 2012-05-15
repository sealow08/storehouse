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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110603071421) do

  create_table "bottles", :force => true do |t|
    t.integer  "supplier_id",    :precision => 38, :scale => 0
    t.integer  "substance_id",   :precision => 38, :scale => 0
    t.integer  "size",           :precision => 38, :scale => 0
    t.integer  "unit_id",        :precision => 38, :scale => 0
    t.string   "po_number"
    t.integer  "group_id",       :precision => 38, :scale => 0
    t.date     "date_received"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cas_number"
    t.integer  "sublocation_id", :precision => 38, :scale => 0
    t.integer  "product_cat_no", :precision => 38, :scale => 0
    t.datetime "retired_at"
    t.boolean  "flammable"
    t.boolean  "hazardous"
    t.string   "barcode"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sublocations", :force => true do |t|
    t.string   "name"
    t.integer  "location_id", :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "substances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sort_keyword"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",    :precision => 38, :scale => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
