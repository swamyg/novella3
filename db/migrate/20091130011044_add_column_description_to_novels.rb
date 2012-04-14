class AddColumnDescriptionToNovels < ActiveRecord::Migration
  def self.up
    add_column :novels, :description, :string, :limit => 255
  end

  def self.down
    remove_column :novels, :description
  end
end
