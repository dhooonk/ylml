module BoxHelper

  def current_major?
    if user_signed_in?
      if (current_user.major == "응용화학과")
        1
      elsif ["응용수학과", "응용물리학과", "우주과학과"].include? current_user.major
        2
      elsif (current_user.major == "산업경영공학과")
        3
      elsif ["전자공학과", "컴퓨터공학과", "생체의공학과", "소프트웨어융합학과"].include? current_user.major
        4
      else
        false
      end
    end
  end

  def apply_range(input)
    if input == "응용화학과"
      return  ("#{Limit.find(1).student_time.chomp("+0900")} ~ #{Limit.find(1).student_time_.chomp("+0900")}")
    elsif input == "산업경영공학과"
      return  ("#{Limit.find(3).student_time.chomp("+0900")} ~ #{Limit.find(3).student_time_.chomp("+0900")}")
    elsif ["응용화학과", "응용수학과", "응용물리학과"].include? input
      return  ("#{Limit.find(2).student_time.chomp("+0900")} ~ #{Limit.find(2).student_time_.chomp("+0900")}")
    else
      return  ("#{Limit.find(4).student_time.chomp("+0900")} ~ #{Limit.find(4).student_time_.chomp("+0900")}")
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

  def current_time4
    if (current_user.identity == "1")
      @current_time = Limit.find(4).student_time
    elsif (current_user.identity == "2")
      @current_time = Limit.find(4).gda_time
    end
  end

  def final_time4
    if (current_user.identity == "1")
      @final_time = Limit.find(4).student_time_
    elsif (current_user.identity == "2")
      @final_time = Limit.find(4).gda_time_
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
    #위 상단은 응용화학과
  def user_apply?
    if ["응용물리학과", "응용수학과", "우주과학과"].include? current_user.major
      if current_user.cabinetApliSci #응용과학대학(응용물리학과,응용수학과,우주과학과)
        redirect_to new_post_path, method: "get"
        flash[:alert] = "이미 신청하셨습니다."
      end
    elsif current_user.major == "산업경영공학과"#산업경영공학과
      if current_user.cabinetIme
        redirect_to new_post_path, method: "get"
        flash[:alert] = "이미 신청하셨습니다."
      end
    elsif ["전자공학과", "컴퓨터공학과", "생체의공학과", "소프트웨어융합학과"].include? current_user.major
      if current_user.cabinetEni
        redirect_to new_post_path, method: "get"
        flash[:alert] = "이미 신청하셨습니다."
      end
    end
  end

  def is_feeOfSch_true?
    if !(user_major?.include? "응용물리학과")
      if current_user.identity == "1"
        if current_user.feeOfSch != true
          redirect_to new_post_path, method: "get"
          flash[:alert] = "학생회비 미납으로 인하여 사물함을 신청하실 수 없습니다."
        end
      end
    end
  end

end
