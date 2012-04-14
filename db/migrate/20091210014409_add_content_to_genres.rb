class AddContentToGenres < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO genres  (`name`,`url`) values ('sci-fi','sci-fi');"
    execute "INSERT INTO genres  (`name`,`url`) values ('romance','romance');"
    execute "INSERT INTO genres  (`name`,`url`) values ('thriller','thriller');"
    execute "INSERT INTO genres  (`name`,`url`) values ('poetry','poetry');"
    execute "INSERT INTO genres  (`name`,`url`) values ('mystery','mystery');"
    execute "INSERT INTO genres  (`name`,`url`) values ('fantasy','fantasy');"
    execute "INSERT INTO genres  (`name`,`url`) values ('tech','tech');"
  end

  def self.down
  end
end
