class CreateActivitiesTable < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.integer :chapter_id
      t.string :activity_type
      t.timestamps
    end
  end

  def self.down
    remove_table :activities
  end
end
