class ChangeNovelTableColumn < ActiveRecord::Migration
  def self.up
    change_column(:novels, :cover, :string, :null => true)
    
  end

  def self.down
    change_column(:novels, :cover, :string, :null => false)

  end
end
