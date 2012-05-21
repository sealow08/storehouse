class AddFlammableToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :flammable, :boolean
  end

  def self.down
    remove_column :bottles, :flammable
  end
end
