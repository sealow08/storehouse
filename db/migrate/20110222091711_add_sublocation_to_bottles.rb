class AddSublocationToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :sublocation_id, :integer
  end

  def self.down
    remove_column :bottles, :sublocation_id
  end
end
