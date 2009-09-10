ActiveRecord::Schema.define(:version => 20090817034552) do

  create_table "options", :force => true do |t|
    t.integer  "vote_id"
    t.string   "name"
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
    t.string   "state",      :default => "new"
    t.string   "kind",       :default => "single_option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
