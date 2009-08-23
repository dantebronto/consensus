class CreateRenumerationContributors < ActiveRecord::Migration
  def self.up
    create_table :renumeration_contributors do |t|
      t.string :name
      t.integer :percentage
      t.boolean :use

      t.timestamps
    end
  end

  def self.down
    drop_table :renumeration_contributors
  end
end
