class MeetupsController < ApplicationController
  # before_action :set_user

  def show
    @meetup = Meetup.find(params[:id])
    @user_meetup = UserMeetup.new
    @users = @meetup.users
    # @markers = @users.geocoded.map do |user|
    #   {
    #     lat: user.latitude,
    #     lng: user.longitude
    #   }
  end

  def new
    @meetup = Meetup.new
  end

  def index
    @meetups = current_user.meetups
  end

  def create
    @meetup = Meetup.new(meetup_params)
    @meetup.passcode = passcode
    @meetup.user = current_user
    #  add location for initial user at signup
    if @meetup.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @meetup = Meetup.find(params[:id])
  end

  def update
    # This method for admin to change - PATCH
    @meetup = Meetup.find(params[:id])
    @meetup.update(meetup_params)
    if @meetup.save
      redirect_to meetup_path # unsure if this will work (meetup_path(@meetup)?)
    else
      render :new
    end
  end

  private

  def meetup_params
    params.require(:meetup).permit(:name, :event_date, :purpose, :location)
  end

  def passcode(length = 5)
    # create password, 5 digit rand numbers
    numbers = (0..9).to_a
    num_array = numbers.sample(length)
    num_array.join
  end
end
