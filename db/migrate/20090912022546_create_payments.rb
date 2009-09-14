class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :tenure
      t.integer :peer_review
      t.integer :hours
      t.integer :worker_misc
      t.integer :worker_capital
      t.integer :total_profits
      t.integer :user_id
      t.integer :remuneration_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
