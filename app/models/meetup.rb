class Meetup < ApplicationRecord
  belongs_to :user
  belongs_to :venue
  has_many :users, through: :user_meetups
end
