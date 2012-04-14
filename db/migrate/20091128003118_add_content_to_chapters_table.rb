class AddContentToChaptersTable < ActiveRecord::Migration
  def self.up
    add_column :chapters, :content, :text, :null=>false, :default=>''
  end

  def self.down
    remove_column :chapters, :content
  end
end
