class CreateNovels < ActiveRecord::Migration
  def self.up
    create_table :novels do |t|
      t.column :name, :string, :null => true, :limit => 128
      t.column :user_id, :integer, :null => false
      t.column :genre_id, :integer, :null => false
      t.column :cover, :string, :null => false, :limit => 255
      t.timestamps
    end
  end

  def self.down
    drop_table :novels
  end
end
