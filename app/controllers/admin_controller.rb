class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?

  def index
    @head = true
    if params[:order].nil?
      if (current_user.major == "응용화학과") || (current_user.major == "산업경영공학과") ## 응용화학과이거나 산업경영공학과일때,(각 과일때,)
        @user_admin = User.where(major: user_major?).order('stuN ASC')
      elsif ["응용수학과", "우주과학과", "응용물리학과"].include? current_user.major #응용과학대일때,
        tmp_arr = []
        tmp_arr = user_major?
        tmp_arr.push('응용화학과')
        @user_admin = User.where(major: tmp_arr).order('stuN ASC')
      else #전자정보대학일때,
        @user_admin = User.where(major: user_major?).order('stuN ASC')
      end
    else
      if user_major?.include? "응용물리학과"
        if params[:order]== '사물함 순'
          tmp_arr = []
          tmp_arr = user_major?
          tmp_arr.push('응용화학과')
          @user_admin = User.where(major: user_major?).includes(:cabinetApliSci).order('cabinet_apli_scis.cabins_aplsci ASC')
        elsif params[:order]== '학번 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('stuN ASC')
        elsif params[:order] == '이름 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('name ASC')
        elsif params[:order] == '권한 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('identity DESC')
        elsif params[:order] == '납부 순'
          @user_admin = User.where.not(major: "산업경영공학과").order('feeOfSch ASC')
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
        elsif params[:order] == '납부 순'
          @user_admin = User.where(major: user_major?).order('feeOfSch ASC')
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
        elsif params[:order] == '납부 순'
          @user_admin = User.where(major: user_major?).order('feeOfSch ASC')
        elsif params[:order] == '권한 순'
          @user_admin = User.where(major: user_major?).order('identity DESC')
        end
      else
        if params[:order]== '사물함 순'
          @user_admin = User.where(major: user_major?).includes(:cabinetEni).order('cabinet_enis.cabins_eni ASC')
        elsif params[:order]== '학번 순'
          @user_admin = User.where(major: user_major?).order('stuN ASC')
        elsif params[:order] == '이름 순'
          @user_admin = User.where(major: user_major?).order('name ASC')
        elsif params[:order] == '납부 순'
          @user_admin = User.where(major: user_major?).order('feeOfSch ASC')
        elsif params[:order] == '권한 순'
          @user_admin = User.where(major: user_major?).order('identity DESC')
        end
      end
    end
  end

  def feeOfSch
    user = User.find(params[:id])
    if user.feeOfSch == true
      user.feeOfSch = "false"
      user.save
    else
      user.feeOfSch = "true"
      user.save
    end

    redirect_to admin_index_path, method:"get"
  end

  def destroy ##특정 1명의 개인의 계정을 삭제하는 액션
    user = User.find(params[:id])
    if (user.identity != "admin")
      tempusers = Tempuser.where(stuN: user.stuN)
      tempusers.destroy_all
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
      uStuN = []
      uStuN2 = []
      users.each do |u|
        uStuN << u.stuN
      end
      users2.each do |u|
        uStuN2 << u.stuN
      end
      Tempuser.where(stuN: uStuN).destroy_all
      Tempuser.where(stuN: uStuN2).destroy_all
      users.where.not(identity: "admin").destroy_all
      users2.where.not(identity: "admin").destroy_all
      flash[:warning] = "전체 계정 정보가 삭제 되었습니다."
      redirect_to admin_index_path
    else
      users = User.where(major: user_major?)
      uStuN = []
      users.each do |u|
        uStuN << u.stuN
      end
      Tempuser.where(stuN: uStuN).destroy_all
      users.where.not(identity: "admin").destroy_all
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
