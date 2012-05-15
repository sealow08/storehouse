class AddCasNumberToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :CAS_number, :string
  end

  def self.down
    remove_column :bottles, :CAS_number
  end
end
