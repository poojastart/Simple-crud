class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters,  if: :devise_controller?
  before_action :set_ransack_query
  protected

  def user_not_authorized
    flash[:alert] = 'You are not uthorized to perform  this action'
    redirect_to root_path
  end

  def set_ransack_query
    @q = Product.ransack(params[:q])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end
