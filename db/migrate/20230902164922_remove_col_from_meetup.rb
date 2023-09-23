class RemoveColFromMeetup < ActiveRecord::Migration[7.0]
  def change
    remove_column :meetups, :type, :string
  end
end
