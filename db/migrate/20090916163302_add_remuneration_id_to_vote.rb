class AddRemunerationIdToVote < ActiveRecord::Migration
  def self.up
    add_column :votes, :remuneration_id, :integer
  end

  def self.down
    remove_column :votes, :remuneration_id
  end
end
