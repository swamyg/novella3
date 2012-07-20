class AddCurrentEditIdToChapters < ActiveRecord::Migration
  def self.up
    add_column :chapters, :current_edit_id, :integer
  end

  def self.down
    remove_column :chapters, :current_edit_id
  end
end
