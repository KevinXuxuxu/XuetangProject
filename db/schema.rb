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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20140710073310) do
=======
ActiveRecord::Schema.define(version: 20140728034216) do
>>>>>>> 31b948ca37b216a6c05883eb2b48917f78ca9307

  create_table "articles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "category_id"
  end

  add_index "articles", ["author_id"], name: "index_articles_on_author_id"
  add_index "articles", ["category_id"], name: "index_articles_on_category_id"

  create_table "categories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.integer  "order"
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "author_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id"
  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

<<<<<<< HEAD
  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.string   "belong"
    t.string   "teacher"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ctime"
  end

  create_table "messages", force: true do |t|
    t.string   "kind"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "status"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

=======
>>>>>>> 6b2895e06d1945cf04888ba161930b7743ef9af9
  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.integer  "topic_id"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "topics", ["parent_id"], name: "index_topics_on_parent_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "stu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
