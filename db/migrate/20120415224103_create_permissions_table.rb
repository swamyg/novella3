class CreatePermissionsTable < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.column :user_id, :integer, :null => false
      t.column :novel_id, :integer, :null => true
      t.column :role, :string, :limit => 32, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
