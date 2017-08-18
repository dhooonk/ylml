module BoxHelper
  def current_time
    if current_user.identity == "1"
      @current_time = Limit.first.student_time
    elsif current_user.identity == "2"
      @current_time = Limit.first.gda_time
    end
  end

  def final_time
    if current_user.identity == "1"
      @final_time = Limit.second.student_time
    elsif current_user.identity == "2"
      @final_time = Limit.second.gda_time
    end
  end
end
