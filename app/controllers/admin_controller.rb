class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?

  def index
    @head = true
    @user_admin = User.all.order('stuN ASC')
    if params[:order]== '사물함 순'
      @user_admin = User.all.order('seatNumber ASC')
    elsif params[:order]== '학번 순'
      @user_admin = User.all.order('stuN ASC')
    elsif params[:order] == '이름 순'
      @user_admin = User.all.order('name ASC')
    end
  end

  def destroy ##특정 1명의 개인의 계정을 삭제하는 액션
    user = User.find(params[:id])
    tmp_user = user
    if (user.identity != "admin")
      user.destroy
    else
      flash[:warning] = "관리자 계정은 삭제할 수 없습니다."
    end
    c = Cabinet.find_by(cabins:tmp_user.seatNumber)
    if !!Cabinet.find_by(cabins:tmp_user.seatNumber)
      c.destroy
    end
    redirect_to admin_index_path
  end

  def destroy_all ##관리자 계정을 제외한 모든 계정 초기화 액션
    User.where(identity: "1").destroy_all
    User.where(identity: "2").destroy_all
    User.where(identity: "3").destroy_all
    Cabinet.destroy_all
    flash[:warning] = "전체 계정 정보가 삭제 되었습니다."
    redirect_to admin_index_path
  end

  def edit
    user=User.find(params[:id])
    user.password='123456'
    user.password_confirmation='123456'
    user.save
    flash[:warning] = "'#{user.name}'사용자의 계정(#{user.email}) 비밀번호가 변경되었습니다."
    redirect_to admin_index_path
  end
end
