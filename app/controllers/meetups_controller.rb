class MeetupsController < ApplicationController
  # before_action :set_user


  def show
    @global_restaurants = ["The Phoenix, Cuisine: British Pub Food Address: 23 Smith St, Chelsea, London SW3 4EE, Distance: Approximately 0.2 miles away",
                           "The Good Life Eatery, Cuisine: Healthy, Vegetarian-Friendly, Address: 59 Sloane Ave, Chelsea, London SW3 3DH, Distance: Approximately 0.4 miles away",
                           "Kurobuta Chelsea, Cuisine: Japanese, Asian Fusion, Address: 312 King's Rd, Chelsea, London SW3 5UH, Distance: Approximately 0.3 miles away",
                           "Medlar, Cuisine: Modern European, Address: 438 King's Rd, Chelsea, London SW10 0LJ, Distance: Approximately 0.4 miles away",
                           "Aubaine, Cuisine: French, European, Address: 260-262 Brompton Rd, Knightsbridge, London SW3 2AS, Distance: Approximately 0.4 miles away"]

    @meetup = Meetup.find(params[:id])
    @user_meetup = UserMeetup.new
    @users = @meetup.users
    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { user: user })
        # marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def new
    @meetup = Meetup.new
  end

  def index
    @meetups = current_user.user_meetups.map(&:meetup)
    # @meetups = current_user.meetups
  end

  def create
    @meetup = Meetup.new(meetup_params)
    @meetup.passcode = passcode
    @meetup.user = current_user
    #  add location for initial user at signup
    if @meetup.save
      redirect_to meetup_path(@meetup), notice: 'Meetup created successfully.'
    else
      render :new
    end
  end

  def create_chatroom
    @meetup = Meetup.find(params[:id])
    # Create a chatroom with the same ID as the meetup
    @chatroom = Chatroom.find_or_create_by(meetup: @meetup)
    # Redirect to the chatroom's show page
    redirect_to meetup_chatroom_path(@meetup, @chatroom)
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
