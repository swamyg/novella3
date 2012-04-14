class AddPermaLinkToNovelsTable < ActiveRecord::Migration
  def self.up
    add_column :novels, :perma_link, :string, :length=>255, :null=>false
  end

  def self.down
    remove_column :novels, :perma_link
  end
end
