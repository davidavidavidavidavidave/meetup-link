class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  helper_method :current_user_already_joined_meetup?

  private

  def current_user_already_joined_meetup?
    joined = @meetup.users.include?(current_user)
    puts "Current User: #{current_user.inspect}, Joined Meetup? #{joined}"
    joined
  end
end
