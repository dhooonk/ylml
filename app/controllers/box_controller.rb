class BoxController < ApplicationController
  before_action :authenticate_user!
  before_action :user_apply?, only: [:index, :create]
  before_action :authenticate_admin!
  # 서비스 기간부터 작동시키기
  # before_action :time_condition

  def index
    @cabinets = Cabinet.all
    # 행           열 #
    number_one = ["01", "02", "03", "04"]
    number_two = ["05", "06", "07", "08"]
    number_thr = ["09", "10", "11", "12"]
    number_fou = (13..16)
    number_fiv = (17..20)
    @number = [number_one, number_two, number_thr, number_fou, number_fiv]
    number_one_dif = ["01", "02"]
    number_two_dif = ["03", "04"]
    number_thr_dif = ["05", "06"]
    number_fou_dif = ["07", "08"]
    number_fiv_dif = ["09", "10"]
    @number_dif = [number_one_dif, number_two_dif, number_thr_dif, number_fou_dif, number_fiv_dif]

  end

  def create
    if  User.find_by(seatNumber:params[:seatNumber])
      redirect_to box_index_path, method:"get"
      flash[:alert] = "이미 신청완료 된 사물함입니다."
    else
      Cabinet.create(cabins: params[:seatNumber], user_id: current_user.id)
      current_user.seatNumber = params[:seatNumber]
      current_user.save
      redirect_to '/'
      flash[:success] = "#{current_user.seatNumber} 사물함이 신청되었습니다."
    end
  end

  def destroy
    user = User.find(params[:id])
    cabinet = Cabinet.find_by(cabins: user.seatNumber)
    cabinet.destroy
    user.seatNumber = nil
    user.save

    redirect_to new_post_path

    flash[:warning] = "사물함이 취소되었습니다."
  end

  private
  def authenticate_admin!
    if current_user.identity != "admin" || current_user.identity != "3"
      if current_time > Time.now || Time.now > final_time
        redirect_to root_path
        flash[:alert] = "신청기간이 아닙니다."
      end
    end
  end
  ##
end
