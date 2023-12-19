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

ActiveRecord::Schema[7.0].define(version: 2023_12_15_220236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_cart_items_on_course_id"
    t.index ["student_id"], name: "index_cart_items_on_student_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "title"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_chapters_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "status"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_applications", force: :cascade do |t|
    t.string "status"
    t.text "cover_letter"
    t.string "phone"
    t.bigint "job_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employer_id"
    t.index ["employer_id"], name: "index_job_applications_on_employer_id"
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["student_id"], name: "index_job_applications_on_student_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "job_type"
    t.string "slug"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "type", default: "Text", null: false
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_lessons_on_chapter_id"
  end

  create_table "purchased_courses", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.jsonb "purchased_items", default: {}
    t.string "stripe_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "current_chapter"
    t.string "completed_status", default: "0"
    t.boolean "new_chapter", default: false
    t.index ["course_id"], name: "index_purchased_courses_on_course_id"
    t.index ["student_id"], name: "index_purchased_courses_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "type", null: false
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "view_chapters", force: :cascade do |t|
    t.bigint "purchased_course_id", null: false
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_view_chapters_on_chapter_id"
    t.index ["purchased_course_id"], name: "index_view_chapters_on_purchased_course_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "courses"
  add_foreign_key "cart_items", "users", column: "student_id"
  add_foreign_key "chapters", "courses"
  add_foreign_key "job_applications", "jobs"
  add_foreign_key "job_applications", "users", column: "employer_id"
  add_foreign_key "job_applications", "users", column: "student_id"
  add_foreign_key "lessons", "chapters"
  add_foreign_key "purchased_courses", "courses"
  add_foreign_key "purchased_courses", "users", column: "student_id"
  add_foreign_key "view_chapters", "chapters"
  add_foreign_key "view_chapters", "purchased_courses"
end
