class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :tenure, :default => 0
      t.integer :peer_review, :default => 0
      t.integer :hours, :default => 0
      t.integer :worker_misc, :default => 0
      t.integer :worker_capital, :default => 0
      t.integer :total_profits, :default => 0
      t.integer :user_id
      t.integer :remuneration_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
