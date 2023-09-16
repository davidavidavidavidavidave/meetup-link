class UserMeetupsController < ApplicationController
  before_action :set_meetup

  def new
    @user_meetup = UserMeetup.new
  end

  def create
    if current_user_already_joined_meetup?
      flash[:notice] = "You have already joined this meetup."
    else
      @user_meetup = UserMeetup.new
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

  def destroy
    user_meetup = current_user.user_meetups.find_by(meetup: @meetup)

    if user_meetup
      user_meetup.destroy
      flash[:notice] = "You have left the meetup."
    else
      flash[:alert] = "You are not a member of this meetup."
    end

    redirect_to @meetup
  end

  def update
  end

  private

  def set_meetup
    @meetup = Meetup.find(params[:meetup_id])
  end

  def user_meetup_params
    params.require(:user_meetup).permit(:meetup_id)
  end

  def current_user_already_joined_meetup?
    @meetup.users.include?(current_user)
  end

  # Method to set user_location to one string for api usage
  # def ll_location
  #   "#{current_user.latitude},#{current_user.longitude}"
  # end
end
