class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.column :name, :string, :null => false, :limit => 32
      t.column :url, :string, :null => false, :limit => 32
      t.timestamps
    end
  end

  def self.down
    drop_table :genres
  end
end
