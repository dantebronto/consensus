class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :name
      t.datetime :expires_on
      t.string :state, :default => "new"
      t.string :type, :default => "single_option"

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
