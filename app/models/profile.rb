class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, :styles=>{:small => "175x175>"},
                    :url  => "/assets/novels/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/novels/:id/:style/:basename.:extension",
                    :default_url => "/images/empty_user_rick.jpg" 
end
