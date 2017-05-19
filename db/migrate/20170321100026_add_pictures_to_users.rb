class AddPicturesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pictures, :string
  end
end
