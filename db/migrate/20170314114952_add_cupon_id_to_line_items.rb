class AddCuponIdToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :cupon_id, :integer
  end
end
