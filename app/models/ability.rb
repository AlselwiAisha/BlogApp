class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :create, Post, author_id: user.id
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
      can :read, :all
    end
  end
end
