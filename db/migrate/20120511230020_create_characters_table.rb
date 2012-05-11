class CreateCharactersTable < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :name, :limit => 255, :null => false
      t.integer :novel_id, :null => false
      t.integer :user_id, :null => false
      t.string :description, :limit => 255
      t.string :character_type, :limit => 32
    end
  end

  def self.down
    drop_table :characters
  end
end
