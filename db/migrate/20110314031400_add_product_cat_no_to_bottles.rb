class AddProductCatNoToBottles < ActiveRecord::Migration
  def self.up
    add_column :bottles, :product_cat_no, :integer
  end

  def self.down
    remove_column :bottles, :product_cat_no
  end
end
