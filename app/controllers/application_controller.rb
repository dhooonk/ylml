class ApplicationController < ActionController::Base
  include AdminHelper
  include BoxHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:stuN])
    devise_parameter_sanitizer.permit(:account_update, keys: [:stuN])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:major])
    devise_parameter_sanitizer.permit(:account_update, keys: [:major])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:identity])
    devise_parameter_sanitizer.permit(:account_update, keys: [:identity])
  end

  def user_apply?
    if !current_user.seatNumber.nil?
      redirect_to :root

      flash[:alert] = "사물함을 이미 신청하셨습니다."
    end
  end

  def admin_not?
    if (current_user.identity != "admin")
      redirect_to '/'
    end
  end

end
