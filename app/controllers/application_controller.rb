class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :devise_strong_parameter, if: :devise_controller?

  private

  def devise_strong_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
