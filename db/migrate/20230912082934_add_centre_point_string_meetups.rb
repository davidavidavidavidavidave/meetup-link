class AddCentrePointStringMeetups < ActiveRecord::Migration[7.0]
  def change
    add_column :meetups, :centre_point_test, :string
  end
end
