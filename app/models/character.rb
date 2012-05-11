class Character < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user
end