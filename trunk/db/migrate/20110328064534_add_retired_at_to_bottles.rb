class AddRetiredAtToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :retired_at, :date
  end

  def self.down
    remove_column :bottles, :retired_at
  end
end
