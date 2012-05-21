class AddHazardousToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :hazardous, :boolean
  end

  def self.down
    remove_column :bottles, :hazardous
  end
end
