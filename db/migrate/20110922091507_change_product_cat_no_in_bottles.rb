class ChangeProductCatNoInBottles < ActiveRecord::Migration
  def self.up
    change_column(:bottles, :product_cat_no, :string)
  end

  def self.down
    change_column(:bottles, :product_cat_no, :integer)
  end
end
