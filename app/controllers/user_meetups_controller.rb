class UserMeetupsController < ApplicationController
  before_action :set_meetup

  def new
    @user_meetup = UserMeetup.new
  end

  def create
    if current_user_already_joined_meetup?
      flash[:notice] = "You have already joined this meetup."
    else
      @user_meetup = UserMeetup.new(user_meetup_params)
      @user_meetup.meetup = @meetup
      @user_meetup.user = current_user
      # 3. update location?
      if @user_meetup.save
        flash[:notice] = "You have successfully joined this meetup!"
      else
        flash[:notice] = "Error. Try again."
      end
    end
    redirect_to meetup_path(@meetup)

  end

  def update
  end

  private

  def set_meetup
    @meetup = Meetup.find(params[:meetup_id])
  end

  def user_meetup_params
    params.require(:user_meetup).permit(:user_location)
  end

  def current_user_already_joined_meetup?
    @meetup.users.include?(current_user)
  end
end
