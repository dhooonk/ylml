module BoxHelper

  def current_major?
    if user_signed_in?
      if (current_user.major == "응용화학과")
        1
      elsif !((current_user.major == "응용화학과") || (current_user.major == "산업경영공학과"))
        2
      elsif (current_user.major == "산업경영공학과")
        3
      else
        false
      end
    end
  end

  def current_time1
    if (current_user.identity == "1")
      @current_time = Limit.find(1).student_time
    elsif (current_user.identity == "2")
      @current_time = Limit.find(1).gda_time
    end
  end

  def final_time1
    if (current_user.identity == "1")
      @final_time = Limit.find(1).student_time_
    elsif (current_user.identity == "2")
      @final_time = Limit.find(1).gda_time_
    end
  end

  def current_time2
    if (current_user.identity == "1")
      @current_time = Limit.find(2).student_time
    elsif (current_user.identity == "2")
      @current_time = Limit.find(2).gda_time
    end
  end

  def final_time2
    if (current_user.identity == "1")
      @final_time = Limit.find(2).student_time_
    elsif (current_user.identity == "2")
      @final_time = Limit.find(2).gda_time_
    end
  end

  def current_time3
    if (current_user.identity == "1")
      @current_time = Limit.find(3).student_time
    elsif (current_user.identity == "2")
      @current_time = Limit.find(3).gda_time
    end
  end

  def final_time3
    if (current_user.identity == "1")
      @final_time = Limit.find(3).student_time_
    elsif (current_user.identity == "2")
      @final_time = Limit.find(3).gda_time_
    end
  end

  def ordinary_user_not?
    if (current_user.identity == "admin")
      redirect_to root_path
      flash[:alert] = "관리자 계정으로는 사물함 신청이 불가능합니다."
    end
  end


  def access_okay?
    if !current_major?
      redirect_to root_path
      flash[:alert] = "해당학과는 이 서비스의 지원을 받지 않습니다."
    end
  end

  def user_apply_chem1?
    if current_user.cabinet
      redirect_to new_post_path, method: "get"
      flash[:alert] = "이미 신청하셨습니다."
    end
  end

  def user_apply_chem2?
    if current_user.cabinetApliSci
      redirect_to new_post_path, method: "get"
      flash[:alert] = "이미 신청하셨습니다."
    end
  end

  def user_apply?
    if !((current_user.major == "응용화학과") || (current_user.major == "산업경영공학과"))
      if current_user.cabinetApliSci
        redirect_to new_post_path, method: "get"
        flash[:alert] = "이미 신청하셨습니다."
      end
    elsif current_user.major == "산업경영공학과"
      if current_user.cabinetIme
        redirect_to new_post_path, method: "get"
        flash[:alert] = "이미 신청하셨습니다."
      end
    end
  end

end
