class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  def after_sign_up_path_for(resource)
    edit_users_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up, keys: [:location_lat, :location_long, :birthdate, :handle, :gender])
  end
end

