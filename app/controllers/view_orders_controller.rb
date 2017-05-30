class ViewOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:sort_order] && params[:sort_order] != 'All'
      @order = ViewOrdersDecorator.decorate_collection(Order.sort_order_all(current_user, params))
    else
      @order = ViewOrdersDecorator.decorate_collection(Order.sort_order(current_user))
    end
  end
end
  