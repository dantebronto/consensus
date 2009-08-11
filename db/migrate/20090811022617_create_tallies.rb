class CreateTallies < ActiveRecord::Migration
  def self.up
    create_table :tallies do |t|
      t.integer :user_id
      t.integer :vote_id
      t.integer :option_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :tallies
  end
end
