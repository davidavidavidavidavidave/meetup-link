class RemoveFieldFromVenue < ActiveRecord::Migration[7.0]
  def change
    remove_column :venues, :type, :string
  end
end
