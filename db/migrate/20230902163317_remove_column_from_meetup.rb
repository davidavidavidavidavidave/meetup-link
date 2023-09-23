class RemoveColumnFromMeetup < ActiveRecord::Migration[7.0]
  def change
    remove_reference :meetups, :venue, null: false, foreign_key: true
  end
end
