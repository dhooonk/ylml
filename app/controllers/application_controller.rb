class ApplicationController < ActionController::Base
  include BoxHelper
  include AdminHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def user_apply?
    if !current_user.seatNumber.nil?
      redirect_to :root

      flash[:alert] = "사물함을 이미 신청하셨습니다."
    end
  end

  def admin_not?
    if current_user.admin == nil
      redirect_to '/'
    end
  end

  def time_condition
    if Time.now >= "2017-08-07 23:15:00 +0900" && Time.now <= "2017-08-08 23:15:00 +0900"
      if current_user.identity == "pfs"
        return true
      elsif current_user.identity == "gda"
        if Time.now >= "2017-08-07 23:20:00 +0900" && "2017-08-08 23:15:00 +0900"
          return true
        else
          redirect_to '/'
        end
      else
        if Time.now >= "2017-08-07 23:25:00 +0900" && "2017-08-08 23:15:00 +0900"
          return true
        else
          redirect_to '/'
        end
      end
    else
      if current_user.identity == "admin"
        return true
      else
        redirect_to '/'
      end
    end
  end
end
