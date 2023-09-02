class AddFieldToVenue < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :purpose, :string
  end
end
