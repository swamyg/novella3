# lib/tasks/populate.rake
namespace :db do
  desc "Fill database with dummy data"
  task :populate => :environment do
    require 'populator'    
    [Novel, Chapter].each(&:delete_all)
    
    User.populate 40 do |user|
      user.login = Populator.words(1)
      user.email = user.login+'@gmail.com'
      user.created_at = 2.years.ago..Time.now
      user.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{user.login}--")
      user.crypted_password = Digest::SHA1.hexdigest("--#{user.salt}--password--") # "password" is the password
      Profile.populate 1 do |profile|
        profile.user_id = user.id
      end
      Novel.populate 1..10 do |novel|
        novel.genre_id = 1..7
        novel.user_id = user.id
        novel.name = Populator.words(1..5).titleize
        novel.perma_link = novel.name.downcase.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9_-]+/, '')
        novel.description = Populator.sentences(2..10)
        novel.created_at = 2.years.ago..Time.now
        Permission.create!(:novel_id => novel.id, :user_id => user.id, :role => 'author')
        index = 1 # for chapter number
        Chapter.populate 1..19 do |chapter|
          chapter.novel_id = novel.id
          chapter.number = index
          chapter.user_id = 1..20
          chapter.title = Populator.words(1..5).titleize
          chapter.content = Populator.sentences(2..15)
          chapter.created_at = 2.years.ago..Time.now
          index=index+1
        end
      end
    end
    puts "Data successfully populated!"   
  end  
end


