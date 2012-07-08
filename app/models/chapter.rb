class Chapter < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user
  has_many :activities
  validates_presence_of :title,:number,:content
  validates_numericality_of :number

  def add_concurrent_editor(user)
    return unless self.activities.where("user_id=#{user.id} AND activity_type='editing' AND chapter_id = #{self.id}").empty?
    self.activities.create!(:user=>user, :activity_type=>'editing', :chapter => self)
  end

  def remove_concurrent_editor(user)
    if record = self.activities.where("user_id=#{user.id} AND activity_type='editing' AND chapter_id = #{self.id}").first
      record.destroy
    end
  end

  def concurrent_editors
    self.activities.where("activity_type = 'editing'").size
  end
end
