class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_paramters, if: :devise_controller?

  include Pundit

  def configure_permitted_parameters
    devise_paramter_sanitizer.for(:sign_up)
      .push(:location_lat, :location_long, :birthdate, :handle)
  end
end

