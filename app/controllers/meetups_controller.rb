class MeetupsController < ApplicationController
  # before_action :set_user

  def show
    @meetup = Meetup.find(params[:id])
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
    # 1. Find the meetup
    @meetup = Meetup.find(params[:id])
    # 2. take new user location (add to user location array?)

    # 3. centre point lat/long recalculated with api call (updated)
    # 4. location updated
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
