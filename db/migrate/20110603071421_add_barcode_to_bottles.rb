class AddBarcodeToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :barcode, :string
  end

  def self.down
    remove_column :bottles, :barcode
  end
end
