class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string, :null => true, :limit => 32
      t.column :login, :string, :null => false, :limit => 32
      t.column :email, :string, :null => false, :limit => 64
      t.column :password, :string, :null => false, :limit => 64
      t.column :dob, :date, :null => true
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
