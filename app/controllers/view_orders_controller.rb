class ViewOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = if (params[:sort_order] && params[:sort_order] != 'All')
      ViewOrdersDecorator.decorate_collection(Order.sort_order_all(current_user, params))
    else
      ViewOrdersDecorator.decorate_collection(Order.sort_order(current_user))
    end
  end
end
  