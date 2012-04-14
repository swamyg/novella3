class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.column :name, :string, :null => true, :limit => 32
      t.column :dob, :date, :null => true
      t.column :webpage, :string, :null => true
      t.column :about_me, :string
      t.column :photo_file_name, :string
      t.column :photo_content_type, :string
      t.column :photo_file_size, :integer
      t.column :photo_updated_at, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
