class CreateVenueMeetupsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :venue_meetups do |t|
      t.references :venue, null: false, foreign_key: true
      t.references :meetup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
