class AddFieldsToUserModel < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean
    add_column :users, :phone_number, :string
  end
end
