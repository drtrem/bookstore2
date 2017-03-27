class AddRateToCommets < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :rate, :integer
  end
end
