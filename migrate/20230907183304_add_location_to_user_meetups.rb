class AddLocationToUserMeetups < ActiveRecord::Migration[7.0]
  def change
    add_column :user_meetups, :user_location, :string
  end
end
