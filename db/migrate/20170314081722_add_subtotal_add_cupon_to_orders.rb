class AddSubtotalAddCuponToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :subtotal, :integer
    add_column :orders, :cupon_id, :integer
    add_column :orders, :delivery_id, :integer
  end
end
