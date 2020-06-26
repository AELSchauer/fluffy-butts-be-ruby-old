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

ActiveRecord::Schema.define(version: 2020_06_11_131409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_insensitive", null: false
    t.string "origin_country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name", null: false
    t.string "link", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_images_on_name"
  end

  create_table "imagings", force: :cascade do |t|
    t.integer "image_id"
    t.string "imagable_type", default: ""
    t.integer "imagable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imagable_id", "imagable_type"], name: "index_imagings_on_imagable_id_and_imagable_type"
    t.index ["image_id"], name: "index_imagings_on_image_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "company"
    t.string "currency"
    t.json "details"
    t.integer "listing_type"
    t.string "link"
    t.decimal "price", precision: 10, scale: 2
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "patterns", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_patterns_on_brand_id"
  end

  create_table "product_lines", force: :cascade do |t|
    t.integer "product_type"
    t.string "name"
    t.string "name_insensitive"
    t.json "details"
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_product_lines_on_brand_id"
  end

  create_table "product_listings", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "listing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listing_id"], name: "index_product_listings_on_listing_id"
    t.index ["product_id"], name: "index_product_listings_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.json "details"
    t.bigint "pattern_id"
    t.bigint "product_line_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pattern_id"], name: "index_products_on_pattern_id"
    t.index ["product_line_id"], name: "index_products_on_product_line_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "proposable_type", default: ""
    t.integer "proposable_id"
    t.json "proposed_change"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposable_id", "proposable_type"], name: "index_proposals_on_proposable_id_and_proposable_type"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.string "taggable_type", null: false
    t.integer "taggable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_tags_on_category"
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "password_digest", default: "", null: false
    t.string "authentication_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "patterns", "brands"
  add_foreign_key "product_lines", "brands"
  add_foreign_key "product_listings", "listings"
  add_foreign_key "product_listings", "products"
  add_foreign_key "products", "patterns"
  add_foreign_key "products", "product_lines"
end
