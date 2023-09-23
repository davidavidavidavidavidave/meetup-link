class AmendCentrePointArrayMeetups < ActiveRecord::Migration[7.0]
  def change
    remove_column :meetups, :centre_point_array
  end
end
