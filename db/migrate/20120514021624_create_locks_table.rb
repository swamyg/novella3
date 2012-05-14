class CreateLocksTable < ActiveRecord::Migration
  def self.up
    create_table :locks do |t|
      t.integer :user_id, :null => false
      t.integer :novel_id, :null => false
      t.timestamps
    end
  end

  def self.down
  end
end
