class RemoveRoleAdminFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :role
    remove_column :users, :admin
  end

  def self.down
    add_column :users, :admin, :boolean
    add_column :users, :role, :string,
  end
end
