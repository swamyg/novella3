class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.column :title, :string, :null => true, :limit => 128
      t.column :user_id, :integer, :null => false
      t.column :novel_id, :integer, :null => false
      t.column :number, :integer, :null => false, :limit => 4
      t.timestamps
    end
  end

  def self.down
    drop_table :chapters
  end
end
