class AddCentrePointArrayToMeetups < ActiveRecord::Migration[7.0]
  def change
    add_column :meetups, :centre_point_array, :string, array: true, default: []
  end
end
