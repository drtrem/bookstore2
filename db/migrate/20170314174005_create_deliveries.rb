class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.string :days
      t.integer :price
    end
  end
end
