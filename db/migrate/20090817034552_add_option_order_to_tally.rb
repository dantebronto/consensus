class AddOptionOrderToTally < ActiveRecord::Migration
  def self.up
    add_column :tallies, :option_order, :string
  end
  
  def self.down
    remove_column :tallies, :option_order
  end
end
