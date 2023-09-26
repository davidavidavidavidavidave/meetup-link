class MeetupsController < ApplicationController
  # before_action :set_user


  def show
    @suggested_places = generate_suggested
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

  def confirmation
    @meetup = Meetup.find(params[:id])
    # You can add any confirmation-related information or logic here
    render 'confirmation'
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

  def generate_suggested
    places_array = ["Scarlet - Sultry 1920s inspired cocktail bar with live jazz and indulgent small plates.",
                    "The Potting Shed - Rustic eatery set in a Victorian venue serving fresh garden-to-table British cuisine.",
                    "Petit Paris - Charming French bistro with checkerboard floors and strings of fairy lights.",
                    "East India Club - Colonial India inspired dining room featuring curries, tandoors and gin fizzes.",
                    "Dolce & Salato - Neighborhood Italian highlighting handmade pastas and wood-fired pizzas.",
                    "Old Tom's Pub - Classic British gastropub,fish & chips and bangers & mash with draft ales",
                    "Wilkes & Co - Sophisticated steakhouse in a converted 18th century townhouse.",
                    "Silk Road - Vibrant Turkish and Lebanese small plates meant for sharing.",
                    "Franklin & Sons - Jewish deli crafting hand sliced sandwiches, bagels and smoked fish.",
                    "The Copper Still - Whisky and Scotch flights paired with modern Scottish fare.",
                    "Platform 9 3/4 - Hogwarts-themed restaurant serving dishes inspired by the wizarding world.",
                    "The Upside Down - Demogorgon servers and food inspired by the horrors of the alternate dimension.",
                    "The Slaughtered Lamb - Ancient pub with foreboding wooden beams and pints of thick ale. Beware the werewolves",
                    "Luna Dorada - Colorful, zesty Mexican cantina with tequila samplers and live mariachi music on weekends.",
                    "Signor Verdi - Italian trattoria crafting roast meats, pastas and pizzas in a wood-burning oven.",
                    "Fat Tuesday's - New Orleans inspired Cajun and Creole cuisine like jambalaya, gumbo and crawfish boils.",
                    "Tsubaki Sushi - Elegant and modern sushi spot featuring rare fish flown in daily.",
                    "Chez Antoinette - Classic French fine dining in a baroque mirrored dining room.",
                    "The Huntsman - Classic British gastropub with hearty roasts, meat pies and bread puddings.",
                    "Black Truffle - Underground speakeasy with molecular gastronomy menu.",
                    "221B Baker Street - Immersive Sherlock Holmes themed restaurant with mystery-inspired dishes and drinks.",
                    "Cau - South American steakhouse with rodizio style grilled meats.",
                    "Two Fold - Contemporary pizza, interesting pizza toppings.",
                    "Casa Cuba - Cuban cuisine, buzzing eatery with mojitos and Latin music.",
                    "The Brewers Inn - Traditional British pub with a restaurant that serves classic pub fare.",
                    "Hood - Plant-based comfort food serving vegan versions of classic dishes.",
                    "Berenjak - Vibrant Persian restaurant inspired by the bustling bazaars of Tehran.",
                    "ClipClop - Wine bar focusing on natural and organic wines."]

    places_array.sample(5)
  end
end
