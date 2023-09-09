class AddPurposeColToMeetup < ActiveRecord::Migration[7.0]
  def change
    add_column :meetups, :purpose, :string
  end
end
