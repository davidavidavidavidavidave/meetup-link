class AddCentrePointMeetups < ActiveRecord::Migration[7.0]
  def change
    add_column :meetups, :centre_point, :float
  end
end
