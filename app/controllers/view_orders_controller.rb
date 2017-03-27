class ViewOrdersController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @order = Order.order(sort_column + ' ' + sort_direction).where(user_id: current_user.id)
  end

  private

  def sort_column
    Order.column_names.include?(params[:sort_order]) ? params[:sort_order] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction_order]) ?  params[:direction_order] : "desc"
  end
end
