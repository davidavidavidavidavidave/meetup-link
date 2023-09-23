class ChatroomsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is signed in

  def show
    @meetup = Meetup.find(params[:meetup_id])

    # Find the chatroom associated with the meetup
    @chatroom = @meetup.chatroom

    if @chatroom.nil?
      # Handle the case where no chatroom is associated with the meetup
      flash[:alert] = "Chatroom not found for this meetup."
      redirect_to @meetup
    else
      # Ensure the association is loaded
      @chatroom.messages.load
      @message = Message.new
    end
  end

  # This is the only create action you need
  def create
    @meetup = Meetup.find(params[:meetup_id])
    # Check if a chatroom already exists for the meetup
    if @meetup.chatroom
      redirect_to meetup_chatroom_path(@meetup, @meetup.chatroom), notice: 'A chatroom already exists for this meetup.'
    else
      # Create a new chatroom for the meetup and associate it with the meetup
      @chatroom = Chatroom.new(meetup: @meetup)

      if @chatroom.save
        redirect_to meetup_chatroom_path(@meetup, @chatroom), notice: 'Chatroom created successfully.'
      else
        flash[:error] = 'Failed to create chatroom.'
        render 'meetups/show'
      end
    end
  end



end
