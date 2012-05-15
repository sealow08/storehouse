class RenameCasNumberInBottles < ActiveRecord::Migration
  def self.up
    change_table :bottles do |t|
      t.rename :CAS_number, :cas_number
    end
  end

  def self.down
    change_table :bottles do |t|
      t.rename :cas_number, :CAS_number 
    end
  end
end
