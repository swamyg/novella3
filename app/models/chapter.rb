class Chapter < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user  
  validates_presence_of :title,:number,:content
  validates_numericality_of :number

  def add_concurrent_user(user)
    return if where
  end
end
