class Novel < ActiveRecord::Base  
  has_many :chapters
  has_many :characters
  has_many :permissions
  belongs_to :user
  belongs_to :genre
  
  has_attached_file :photo, :styles=>{:small => "150x150>"},
                    :url  => "/assets/novels/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/novels/:id/:style/:basename.:extension",
                    :default_url => "/images/empty_book.jpg"  
  
  validates_presence_of     :name, :genre_id
  validates_length_of       :description, :maximum => 255
  validates_uniqueness_of   :perma_link, :name, :case_sensitive => false

  #callbacks
  after_create :set_owner
  
  #specify the number of itesm per page for will paginate
  def self.per_page
    10
  end
  
  def self.popular(genre_id, page)
    genre_clause = genre_id > 0 ? "genre_id = #{genre_id}" : ""
    paginate :page => page,
             :conditions => [genre_clause]
  end
  
  def self.recent(genre_id, page)
    genre_clause = genre_id > 0 ? "genre_id = #{genre_id}" : ""
    paginate :page => page,
             :order => 'created_at DESC',
             :conditions => [genre_clause]           
  end

  def author
    user
  end

  def locked?(user)
    lock = Lock.where(:novel_id => self.id).first
    return if lock.nil?
    !(lock.user_id == user.id)
  end

  def lock(user)
    return if Lock.where(:novel_id => self.id, :user_id => user.id).present?
    Lock.create!(:novel_id => self.id, :user_id => user.id)
  end

  def unlock
    Lock.find_by_novel_id(self.id).destroy
  end

  private

  def set_owner
    self.user.permissions.create!(:novel => self, :role => 'author')
  end

end
