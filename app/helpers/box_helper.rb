module BoxHelper
  def current_time
    if (current_user.identity == "1")
      @current_time = Limit.first.student_time
    elsif (current_user.identity == "2")
      @current_time = Limit.first.gda_time
    end
  end

  def final_time
    if (current_user.identity == "1")
      @final_time = Limit.first.student_time_
    elsif (current_user.identity == "2")
      @final_time = Limit.first.gda_time_
    end
  end

  def ordinary_user_not?
    if (current_user.identity == "admin")
      redirect_to root_path
      flash[:alert] = "관리자 계정으로는 사물함 신청이 불가능합니다."
    end
  end

  def current_major?
    if user_signed_in?
      if (current_user.major == "응용화학과") && !(current_user.applied_sci_admin)
        1
      elsif (current_user.applied_sci_admin)
        2
      elsif (current_user.major == "산업경영공학과")
        3
      else
        false
      end
    end
  end

  def access_okay?
    if !current_major?
      redirect_to root_path
      flash[:alert] = "해당학과는 이 서비스의 지원을 받지 않습니다."
    end
  end
end
