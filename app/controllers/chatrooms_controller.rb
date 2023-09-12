class ChatroomsController < ApplicationController
  def show
    @meetup = Meetup.find(params[:meetup_id])
    @chatroom = Chatroom.find(params[:meetup_id])
    @message = Message.new # If you want to initialize a new message

    # You can also retrieve messages related to this chatroom
    @messages = @chatroom.messages
  end

  
end
