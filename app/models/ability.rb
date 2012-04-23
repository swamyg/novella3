class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read], :all
    can [:create, :new], Novel if !user.nil?
    can [:delete, :update], Novel do |novel|
      user.is_owner?(novel)
    end
    can [:edit], Novel do |novel|
      user.is_owner?(novel) || user.is_editor?(novel)
    end
    can [:manage], Chapter do |chapter|
      user.is_author?(chapter.novel) || user.is_editor?(chapter.novel) || user.is_contributor?(chapter.novel) || user.is_moderator?
    end
  end
end
