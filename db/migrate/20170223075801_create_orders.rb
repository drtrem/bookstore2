class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.string :card_number
      t.string :name_on_card
      t.string :mm_yy
      t.string :cvv

      t.timestamps
    end
  end
end
