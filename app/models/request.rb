class Request < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user

  scope :approved, where(:status => 'approved')
  scope :pending, where(:status => 'pending')
  scope :denied, where(:status => 'denied')

  def to_user
    User.find(to_user_id)
  end

  def from_user
    User.find(from_user_id)
  end

  def novel
    Novel.find(novel_id)
  end
end
