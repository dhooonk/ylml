class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?

  def index
    @head = true
    if params[:order].nil?
      if (current_user.major == "응용화학과") || (current_user.major == "산업경영공학과")
        @user_admin = User.where(major: user_major?).order('stuN ASC')
      else
        @user_admin = User.where.not(major: "산업경영공학과").order('stuN ASC')
      end
    else
      if user_major?.include? "응용물리학과"
        if params[:order]== '사물함 순'
          @user_admin = User.where.not(major: "산업경영공학과").includes(:cabinetApliSci).order('cabinet_apli_scis.cabins_aplsci ASC')
        elsif params[:order]== '학번 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('stuN ASC')
        elsif params[:order] == '이름 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('name ASC')
        elsif params[:order] == '권한 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('identity DESC')
        else
          @user_admin = User.where.not(major: "산업경영공학과").order('major DESC')
        end
      elsif user_major? == "응용화학과"
        if params[:order]== '사물함(학과) 순'
          @user_admin = User.where(major: user_major?).includes(:cabinet).order('cabinets.cabin ASC')
        elsif params[:order]== '사물함(단과대) 순'
          @user_admin = User.where(major: user_major?).includes(:cabinetApliSci).order('cabinet_apli_scis.cabins_aplsci ASC')
        elsif params[:order]== '학번 순'
          @user_admin = User.where(major: user_major?).order('stuN ASC')
        elsif params[:order] == '이름 순'
          @user_admin = User.where(major: user_major?).order('name ASC')
        elsif params[:order] == '권한 순'
          @user_admin = User.where(major: user_major?).order('identity DESC')
        end
      elsif user_major? == "산업경영공학과"
        if params[:order]== '사물함 순'
          @user_admin = User.where(major: user_major?).includes(:cabinetIme).order('cabinet_imes.cabins_ime ASC')
        elsif params[:order]== '학번 순'
          @user_admin = User.where(major: user_major?).order('stuN ASC')
        elsif params[:order] == '이름 순'
          @user_admin = User.where(major: user_major?).order('name ASC')
        elsif params[:order] == '권한 순'
          @user_admin = User.where(major: user_major?).order('identity DESC')
        end
      end
    end
  end

  def destroy ##특정 1명의 개인의 계정을 삭제하는 액션
    user = User.find(params[:id])
    if (user.identity != "admin")
      user.destroy
    else
      flash[:warning] = "관리자 계정은 삭제할 수 없습니다."
    end

    redirect_to admin_index_path
  end

  def destroy_all ##관리자 계정을 제외한 모든 계정 초기화 액션
    if !((current_user.major == "산업경영공학과") || (current_user.major == "응용화학과"))
      users = User.where(major: user_major?)
      users2 = User.where(major: "응용화학과")
      users.where(identity: "1").destroy_all
      users.where(identity: "2").destroy_all
      users.where(identity: "3").destroy_all
      users2.where(identity: "1").destroy_all
      users2.where(identity: "2").destroy_all
      users2.where(identity: "3").destroy_all
      flash[:warning] = "전체 계정 정보가 삭제 되었습니다."
      redirect_to admin_index_path
    else
      users = User.where(major: user_major?)
      users.where(identity: "1").destroy_all
      users.where(identity: "2").destroy_all
      users.where(identity: "3").destroy_all
      flash[:warning] = "전체 계정 정보가 삭제 되었습니다."
      redirect_to admin_index_path
    end
  end

  def edit
    user=User.find(params[:id])
    user.password='123456'
    user.password_confirmation='123456'
    user.save
    flash[:warning] = "'#{user.name}'사용자의 계정(#{user.stuN}) 비밀번호가 변경되었습니다."
    redirect_to admin_index_path
  end
end
