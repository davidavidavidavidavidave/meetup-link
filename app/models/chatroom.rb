class Chatroom < ApplicationRecord
  belongs_to :meetup
  before_create :set_name_from_meetup
  has_many :messages

  private

  def set_name_from_meetup
    self.name = meetup.name
  end
end
