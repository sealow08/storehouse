class AddSortKeywordToSubstances < ActiveRecord::Migration
  def self.up
    add_column :substances, :sort_keyword, :string
  end

  def self.down
    remove_column :substances, :sort_keyword
  end
end
