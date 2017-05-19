class ViewOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:sort_order] && params[:sort_order] != 'All'
      @order = ViewOrdersDecorator.decorate_collection(Order.order(id: :desc).where(user_id: current_user.id).where(state: params[:sort_order]))
    else
      @order = ViewOrdersDecorator.decorate_collection(Order.order(id: :desc).all.where(user_id: current_user.id))
    end
  end
end
 