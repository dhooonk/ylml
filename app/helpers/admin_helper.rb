module AdminHelper
  def user_admin?
    !!(current_user.identity == "admin")
  end
end
