module AdminHelper
  def user_admin?
    !current_user.admin == nil?
  end
end
