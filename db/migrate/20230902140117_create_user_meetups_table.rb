class CreateUserMeetupsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_meetups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meetup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
