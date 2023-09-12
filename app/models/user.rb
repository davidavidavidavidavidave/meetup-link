class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meetups, class_name: "Meetup", foreign_key: "user_id"
  has_many :attending_meetups, class_name: "UserMeetup", foreign_key: "user_id"
  has_many :user_meetups

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
