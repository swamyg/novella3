class CreateRequestsTable < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.column :from_user_id, :integer, :null => false
      t.column :to_user_id, :integer, :null => false
      t.column :novel_id, :integer, :null => false
      t.column :status, :string, :default => 'pending'
      t.column :message, :text
      t.column :comment, :text
      t.column :dismissed, :boolean, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
