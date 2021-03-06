# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090919012449) do

  create_table "options", :force => true do |t|
    t.integer  "vote_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_id"
  end

  create_table "payments", :force => true do |t|
    t.integer  "tenure",          :default => 0
    t.integer  "peer_review",     :default => 0
    t.integer  "hours",           :default => 0
    t.integer  "worker_misc",     :default => 0
    t.integer  "worker_capital",  :default => 0
    t.integer  "total_profits",   :default => 0
    t.integer  "user_id"
    t.integer  "remuneration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "remunerations", :force => true do |t|
    t.integer  "tenure"
    t.integer  "peer_review"
    t.integer  "hours"
    t.integer  "worker_misc"
    t.integer  "org_misc"
    t.integer  "worker_capital"
    t.integer  "org_capital"
    t.integer  "total_profits"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tallies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vote_id"
    t.integer  "option_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "option_order"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "login"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "permission_level", :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.string   "name"
    t.datetime "expires_on"
    t.string   "state",           :default => "new"
    t.string   "kind",            :default => "single_option"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "remuneration_id"
  end

end
