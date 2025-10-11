class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    # Check password confirmation manually
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:alert] = "
Password and confirmation did not match 😓"
      redirect_to new_user_registration_path and return
    end

    super do |resource|
      apply_referral_if_present(resource) if resource.persisted?
    end
  end

  private

  def apply_referral_if_present(user)
    token = params[:ref] || params[:referral_token] || session.delete(:referral_token)
    return unless token.present?

    referral = Referral.find_by(token: token, claimed: false)
    return unless referral
    return if referral.referrer_id == user.id

    referral.mark_claimed!(user: user)
    user.update!(referred_by: referral.referrer)
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
