class AddPaymentIdToOption < ActiveRecord::Migration
  def self.up
    add_column :options, :payment_id, :integer
  end

  def self.down
    remove_column :options, :payment_id
  end
end
