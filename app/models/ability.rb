# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Comment
      can :create, Like
      can :create , Post
      can :destroy, Comment, author_id: user.id
      can :destroy, Post, author_id: user.id
      can :destroy, Like, author_id: user.id
    end
  end
end
