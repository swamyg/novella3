class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.column :friend_id, :integer, :null => false
      t.timestamps      
    end
  end

  def self.down
    drop_table :friends
  end
end
