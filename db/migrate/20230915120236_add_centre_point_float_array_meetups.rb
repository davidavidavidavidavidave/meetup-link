class AddCentrePointFloatArrayMeetups < ActiveRecord::Migration[7.0]
  def change
    add_column :meetups, :centre_point_array, :float, array: true, default: []
  end
end
