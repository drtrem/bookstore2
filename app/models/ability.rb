class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can [:read, :cupon_apply], Cart
    can :create, [Order, LineItem, Cart]
    if user.persisted?
      can :read, Order, user_id: user.id
      can :manage, User, id: user.id
      if user.role == 'admin'
        can :read, ActiveAdmin::Page, namespace_name: :admin
        can :manage, :all
      end
    end
  end
end