class RemoveLocationIdFromBottles < ActiveRecord::Migration
  def self.up
    remove_column :bottles, :location_id
  end

  def self.down
    add_column :bottles, :location_id, :integer
  end
end
