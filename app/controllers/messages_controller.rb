class MessagesController < ApplicationController

  def create
    @meetup = Meetup.find(params[:meetup_id])
    @chatroom = @meetup.chatroom
    @message = @chatroom.messages.new(message_params)
    @message.user = current_user
    # @message = @chatroom.messages.new(message_params)
    @message.user = current_user # Assuming you have user authentication

    @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(
          partial: "messages/message",
          locals: {message: @message}
        )
      )
    head :ok
  end

  private
  
  def message_params
    params.require(:message).permit(:content)
  end

end
