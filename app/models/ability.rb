# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :create, :read, :update, to: :cru
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
        can :access, :rails_admin 
        can :manage, :dashboard    
      end
      if user.vendor?
        can [:read, :update], Restaurant,  user_id: user.id
        can :create, Restaurant if user.restaurant.nil?
        can [:read, :update, :create], Branch, restaurant_id: user.restaurant.id
      end
      if user.customer?
        can :read, Restaurant
        can :create, Order, user_id: user.id
        can :read, Order, user_id: user.id
        can :create, OrderLine
        can :read, MenuItem
        can :delete, OrderLine
      end
      
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    
  end
end
