class CreateRemunerations < ActiveRecord::Migration
  def self.up
    create_table :remunerations do |t|
      t.integer :tenure
      t.integer :peer_review
      t.integer :hours
      t.integer :worker_misc
      t.integer :org_misc
      t.integer :worker_capital
      t.integer :org_capital
      t.integer :total_profits
      t.date	:start_date
      t.date	:end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :remunerations
  end
end
