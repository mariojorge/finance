# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_12_003735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ticket_moviments", force: :cascade do |t|
    t.integer "moviment_type"
    t.date "moviment_date"
    t.string "institution"
    t.bigint "wallet_ticket_id"
    t.integer "quantity"
    t.decimal "price"
    t.date "com_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dividend_type"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ticket_class"
  end

  create_table "wallet_tickets", force: :cascade do |t|
    t.bigint "wallet_id"
    t.bigint "ticket_id"
    t.decimal "average_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "current_price", precision: 18, scale: 2
    t.boolean "finished"
    t.decimal "total", precision: 18, scale: 2
    t.decimal "total_invested", precision: 18, scale: 2
    t.decimal "stock_equity", precision: 18, scale: 2
    t.decimal "profit", precision: 18, scale: 2
    t.decimal "profit_percent", precision: 18, scale: 2
    t.decimal "dividends", precision: 18, scale: 2
    t.decimal "final_profit", precision: 18, scale: 2
    t.decimal "final_profit_percent", precision: 18, scale: 2
    t.decimal "current_variation", precision: 10, scale: 2
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
