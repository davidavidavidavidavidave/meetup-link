class UserMeetupsController < ApplicationController
before_action :set_meetup

  def new
  @user_meetup = UserMeetup.new
  end

  def create
    # Find meetup using params id, verify existence
    # If exists code below, otherwise error message

    # 1. User accesses particular meetup via id
    @user_meetup = UserMeetup.new(user_meetup_params)
    # 2. Assign current user to meetup
    # - meetup_id = id
    @user_meetup.meetup_id = params[:id]
    # - user_id = current user
    @user_meetup.user_id = current_user
    # 3. update location?
    if @user_meetup.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  end

  private

  def set_meetup
    @meetup = Meetup.find(params[:meetup_id])
  end

  def user_meetup_params
    params.require(:user_meetup).permit(:location)
  end
end

# def create
#   @meetup = Meetup.new(meetup_params)
#   @meetup.passcode = passcode
#   @meetup.user = current_user
#   #  add location for initial user at signup
#   if @meetup.save
#     redirect_to root_path
#   else
#     render :new
#   end
# end
