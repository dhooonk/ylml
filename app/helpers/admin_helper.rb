module AdminHelper
  def user_admin?
    !!(current_user.identity == "admin")
  end

  def user_major?
    if current_user.major == "응용화학과"
      return "응용화학과"
    elsif current_user.major == "산업경영공학과"
      return "산업경영공학과"
    else
      ["응용수학과", "우주과학과", "응용물리학과"]
    end
  end
end
