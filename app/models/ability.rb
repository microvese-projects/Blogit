class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return unless user.present?

    can :create, Post
    can :create, Comment
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id

    return unless user.role == 'admin'

    can :manage, :all
  end
end
