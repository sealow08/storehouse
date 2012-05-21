class RemoveInvoiceNumberFromBottles < ActiveRecord::Migration
  def self.up
    remove_column :bottles, :invoice_number
  end

  def self.down
    add_column :bottles, :invoice_number, :string
  end
end
