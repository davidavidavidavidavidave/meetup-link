class MeetupsController < ApplicationController
  # before_action :set_user


  def show
    @global_restaurants = ["Brasserie Zédel - Classic French brasserie located in a stunning Art Deco setting. 20 Sherwood St, Soho, London W1F 7ED",
                           "Dishoom - Popular Indian restaurant inspired by the Irani cafés of Bombay. 5 St Martin's Ln London WC2N 4AP",
                           "Hawksmoor Air Street - Steakhouse known for its premium quality steaks and seafood. 5A Air St, London W1J 0AD",
                           "Duck & Rice - Modern Chinese gastropub that combines classic Cantonese cuisine with a pub-style setting. 90 Berwick St, Soho, London W1F 0QB",
                           "Barrafina Dean Street - Spanish tapas restaurant that offers a range of authentic and flavorful dishes. 26-27 Dean St, Soho, London W1D 3LL",
                           "Polpo Soho - Venetian-inspired restaurant known for its small plates and relaxed ambiance. 41 Beak St, Soho, London W1F 9SB",
                           "Honest Burgers - Known for its delicious, locally-sourced burgers made with high-quality ingredients. 4 Market Pl, London W1W 8AD",
                           "The Riding House Café - Brasserie offering a diverse menu of British and European dishes, 43-51 Great Titchfield St, Fitzrovia, London W1W 7PQ"]

    @meetup = Meetup.find(params[:id])
    @users = @meetup.users
    @coordinates = user_coordinates
    @meetup.centre_point_array = geocode_centre
    @markers = user_markers
    @centre_point = centre_point_object
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

  def join
    passcode = params[:passcode]
    meetup = Meetup.find_by(passcode: passcode)

    if meetup
      redirect_to meetup_path(meetup)
    else
      flash[:alert] = "Invalid passcode. Please try again."
      redirect_to root_path
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

  def user_markers
    markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { user: user }),
        marker_html: render_to_string(partial: "marker")
      }
    end
    markers
  end

  def centre_point_object
    {
      lat: @meetup.centre_point_array[0],
      lng: @meetup.centre_point_array[1],
      centre_window_html: render_to_string(partial: "centre_window", locals: { centre: geocode_address(@meetup.centre_point_array) }),
      centre_marker_html: render_to_string(partial: "centre_marker")
    }
  end

  def user_coordinates
    coordinates = @users.map do |user|
      [user.latitude, user.longitude]
    end
    coordinates
  end

  def geocode_address(coordinates)
    results = Geocoder.search(coordinates)
    "#{results.first.street}, #{results.first.city}, #{results.first.postal_code}"
  end

  def geocode_centre
    Geocoder::Calculations.geographic_center(@coordinates)
  end
end
