module TempusersHelper
  def reject_access!
    redirect_to '/' if user_signed_in?
  end
end
