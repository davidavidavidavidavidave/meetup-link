class Meetup < ApplicationRecord
  belongs_to :user, class_name: "User"

  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_one :chatroom, dependent: :destroy
  after_create :create_chatroom

  def create_chatroom
    build_chatroom.save
  end

  # belongs_to :venue
  # has_many :users, through: :user_meetups
end
