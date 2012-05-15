class RemoveContainerEmptyFromBottles < ActiveRecord::Migration
  def self.up
    remove_column :bottles, :container_empty
  end

  def self.down
    add_column :bottles, :container_empty, :boolean
  end
end
