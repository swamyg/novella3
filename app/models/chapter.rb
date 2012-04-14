class Chapter < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user  
  validates_presence_of :title,:number,:content
  validates_numericality_of :number  
end
