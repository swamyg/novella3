class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :text, :string, :null => false, :limit => 32
      t.column :url, :string, :null => false, :limit => 32      
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
