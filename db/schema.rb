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

ActiveRecord::Schema[7.0].define(version: 2022_12_20_075244) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "practitioner_id", null: false
    t.date "date"
    t.boolean "approved"
    t.string "appointment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_appointments_on_practitioner_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "department_practitioners", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "practitioner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_department_practitioners_on_department_id"
    t.index ["practitioner_id"], name: "index_department_practitioners_on_practitioner_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["appointment_id"], name: "index_messages_on_appointment_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "payment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "delivered"
    t.index ["payment_id"], name: "index_orders_on_payment_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "patient_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.date "dob"
    t.string "location"
    t.string "blood_group"
    t.float "height"
    t.float "weight"
    t.string "phone_number"
    t.float "bmi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patient_profiles_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practitioner_profiles", force: :cascade do |t|
    t.bigint "practitioner_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.date "dob"
    t.string "phone_number"
    t.string "location"
    t.string "blood_group"
    t.float "weight"
    t.float "bmi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practitioner_id"], name: "index_practitioner_profiles_on_practitioner_id"
  end

  create_table "practitioners", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_carts_on_order_id"
    t.index ["product_id"], name: "index_shopping_carts_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "practitioners"
  add_foreign_key "appointments", "users"
  add_foreign_key "department_practitioners", "departments"
  add_foreign_key "department_practitioners", "practitioners"
  add_foreign_key "messages", "appointments"
  add_foreign_key "orders", "payments"
  add_foreign_key "orders", "users"
  add_foreign_key "patient_profiles", "users"
  add_foreign_key "practitioner_profiles", "practitioners"
  add_foreign_key "shopping_carts", "orders"
  add_foreign_key "shopping_carts", "products"
end
