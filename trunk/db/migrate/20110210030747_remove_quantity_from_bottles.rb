class RemoveQuantityFromBottles < ActiveRecord::Migration
  def self.up
    remove_column :bottles, :quantity
  end

  def self.down
    add_column :bottles, :quantity, :integer
  end
end
