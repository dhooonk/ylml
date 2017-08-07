class AdminController < ApplicationController
  before_action :user_signed?
  before_action :admin_not?

  def index
    @head = true
    @user_admin = User.all.order('stuN ASC')
    
  end

  def destroy ##특정 1명의 개인의 계정을 삭제하는 액션
    user = User.find(params[:id])
    if user.admin != true
      user.destroy
    else
      flash[:warning] = "관리자 계정은 삭제할 수 없습니다."
    end
    c = Cabinet.find_by(cabins:user.seatNumber)
    if !!Cabinet.find_by(cabins:user.seatNumber)
      c.destroy
    end
    redirect_to admin_index_path
  end

  def destroy_all ##관리자 계정을 제외한 모든 계정 초기화 액션
    User.where(admin: nil).destroy_all
    Cabinet.destroy_all
    flash[:warning] = "전체 계정 정보가 초기화 되었습니다."
    redirect_to admin_index_path
  end
end
