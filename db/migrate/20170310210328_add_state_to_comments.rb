class AddStateToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :state, :string
  end
end
