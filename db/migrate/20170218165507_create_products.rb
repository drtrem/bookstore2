class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :authors
      t.decimal :price
      t.integer :quantity
      t.text :description
      t.date :year
      t.string :dimensions
      t.string :materials

      t.timestamps
    end
  end
end
