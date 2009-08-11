class ChangeVoteTypeToKind < ActiveRecord::Migration
  def self.up
    rename_column :votes, :type, :kind
  end

  def self.down
    rename_column :votes, :kind, :type
  end
end
