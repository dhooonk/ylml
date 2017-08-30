class ApplicationController < ActionController::Base
  include AdminHelper
  include BoxHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:stuN, :email, :major, :identity, :name, :password, :password_confirmation, :remember_me]
    update_attrs = [:password, :password_confirmation, :current_password]

    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
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

# 전공판단
def applchem_not?
  if (current_user.major != "응용화학과")
    redirect_to '/'
  end
end

def applsci_not?
  if (current_user.major != "응용물리학과" || current_user.major != "응용수학과" || current_user.major != "응용화학과" || current_user.major != "우주과학과")
    redirect_to '/'
  end
end

def ime_not?
  if (current_user.major != "산업경영공학과")
    redirect_to '/'
  end
end

# 권한판단
def ugstd_not?
  if (current_user.identity != "1")
    redirect_to '/'
  end
end
def gstd_not?
  if (current_user.major != "2")
    redirect_to '/'
  end
end


end
