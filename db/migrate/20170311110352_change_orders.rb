class ChangeOrders < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|
      t.remove :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_zip, :shipping_country, :shipping_phone, :first_name, :last_name, :address, :city, :zip, :country, :phone
    end
  end
end
