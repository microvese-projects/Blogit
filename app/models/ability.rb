# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    return unless user.present?
    can :read, :all
    can :create, Post
    can :create, Comment
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
    
    if user.role == 'admin'
      can :manage, :all
    else
      return
    end
  end
end
