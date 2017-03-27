class ChangeProduct < ActiveRecord::Migration[5.0]
  def change
  	change_table :products do |t|
		  t.remove :quantity, :authors
		  t.integer :category, :authors
		end
  end
end
