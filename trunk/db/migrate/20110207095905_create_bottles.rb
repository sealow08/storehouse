class CreateBottles < ActiveRecord::Migration
  def self.up
    create_table :bottles do |t|
      t.integer :supplier_id
      t.integer :substance_id
      t.decimal :size
      t.integer :unit_id
      t.integer :quantity
      t.boolean :container_empty
      t.integer :location_id
      t.string :invoice_number
      t.string :po_number
      t.integer :group_id
      t.date :date_received

      t.timestamps
    end
  end

  def self.down
    drop_table :bottles
  end
end
