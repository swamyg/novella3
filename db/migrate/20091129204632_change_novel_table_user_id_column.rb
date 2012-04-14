class ChangeNovelTableUserIdColumn < ActiveRecord::Migration
  def self.up
    change_column(:novels, :user_id, :int, :null => true)
  end

  def self.down
    change_column(:novels, :user_id, :int, :null => false)
  end
end
