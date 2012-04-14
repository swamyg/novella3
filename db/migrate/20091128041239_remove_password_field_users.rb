class RemovePasswordFieldUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :password
  end

  def self.down
    add_column :users, :password, :string, :null => false, :limit => 64
  end
end
