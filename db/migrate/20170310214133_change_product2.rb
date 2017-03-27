class ChangeProduct2 < ActiveRecord::Migration[5.0]
  def change
  	change_table :products do |t|
		  t.remove :category, :authors
		  t.belongs_to :author, index: true
		  t.belongs_to :category, index: true
		end
  end
end
