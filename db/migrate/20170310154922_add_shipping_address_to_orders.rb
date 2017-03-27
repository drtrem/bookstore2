class AddShippingAddressToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipping_first_name, :string
    add_column :orders, :shipping_last_name, :string
    add_column :orders, :shipping_address, :string
    add_column :orders, :shipping_city, :string
    add_column :orders, :shipping_zip, :string
    add_column :orders, :shipping_country, :string
    add_column :orders, :shipping_phone, :string
  end
end
