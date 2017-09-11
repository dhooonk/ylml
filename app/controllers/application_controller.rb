class ApplicationController < ActionController::Base
  include AdminHelper
  include BoxHelper
  include TempusersHelper
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


  def admin_not?
    if (current_user.identity != "admin")
      redirect_to '/'
    end
  end

# 전공판단
def applchem_not?
  if (current_user.major != "응용화학과")
    redirect_back(fallback_location: choose_index_path)
    flash[:alert] = "응용화학과 관계자만 접근가능합니다. "
  end
end

def applsci_not?
  if !(current_user.major == "응용화학과" || current_user.major == "응용물리학과" || current_user.major == "응용수학과" || current_user.major == "우주과학과")
    redirect_back(fallback_location: choose_index_path)
    flash[:alert] = "응용과학대학 관계자만 접근가능합니다. "
  end
end

def ime_not?
  if (current_user.major != "산업경영공학과")
    redirect_back(fallback_location: choose_index_path)
    flash[:alert] = "산업경영공학과 관계자만 접근가능합니다."
  end
end

def eni_not?
  if !(["전자공학과", "컴퓨터공학과", "생체의공학과", "소프트웨어융합학과"].include? current_user.major)
    redirect_back(fallback_location: choose_index_path)
    flash[:alert] = "전자정보대학 관계자만 접근가능합니다. "
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
