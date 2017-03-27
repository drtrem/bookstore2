class CuponAdd < ActiveRecord::Migration[5.0]
  def change
  	  create_table :cupons do |t|
      t.integer :number
      t.integer :price

      t.timestamps
    end
  end
end
