class CreateRequestsTable < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.column :from_user_id, :integer, :null => false
      t.column :to_user_id, :integer, :null => false
      t.column :novel_id, :integer, :null => false
      t.column :message, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
