class AddShippingBillingAddressToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :zip, :string
    add_column :users, :country, :string
    add_column :users, :phone, :string
    add_column :users, :shipping_first_name, :string
    add_column :users, :shipping_last_name, :string
    add_column :users, :shipping_address, :string
    add_column :users, :shipping_city, :string
    add_column :users, :shipping_zip, :string
    add_column :users, :shipping_country, :string
    add_column :users, :shipping_phone, :string
  end
end
