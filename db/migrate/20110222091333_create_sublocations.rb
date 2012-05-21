class CreateSublocations < ActiveRecord::Migration
  def self.up
    create_table :sublocations do |t|
      t.string :name
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sublocations
  end
end
