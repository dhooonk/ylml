class Users::SessionsController < Devise::SessionsController
  before_action :tempuser_join_us?,              only: [:create]
  before_action :configure_permitted_parameters, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     super
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  def tempuser_join_us?
    if !User.find_by(stuN: params[:user][:login]) && !!Tempuser.find_by(stuN: params[:user][:login])
      tempuser = Tempuser.find_by(stuN: params[:user][:login])
      major = tempuser.major
      name  = tempuser.name
      flash[:alert] = "#{name}님, #{major}의 신청기간은 '#{apply_range(major)}'입니다."
      redirect_to new_user_session_path, method: "get"
    end
  end

end
