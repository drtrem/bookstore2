class AddCheckToMyUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :check, :boolean
  end
end
