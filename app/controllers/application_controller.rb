class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_referral_token



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :wp_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :wp_number])
  end

  
private

def store_referral_token
  if params[:ref].present?
    session[:referral_token] = params[:ref]
  end
end
end
