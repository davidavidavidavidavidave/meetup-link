class AddLatAndLongToMeetup < ActiveRecord::Migration[7.0]
  def change
    add_column :meetups, :centre_point_latitude, :float
    add_column :meetups, :centre_point_longitude, :float
  end
end
