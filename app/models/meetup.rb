class Meetup < ApplicationRecord
  belongs_to :user, class_name: "User"
  # belongs_to :venue
  # has_many :users, through: :user_meetups
end
