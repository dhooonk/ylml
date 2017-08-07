class BoxController < ApplicationController
  before_action :user_apply?, only: [:index, :create]
  before_action :user_signed?
  before_action :time_condition

  def index
    @cabinets = Cabinet.all
    # 행           열 #
    number_one = (1..4)
    number_two = (5..8)
    number_thr = (9..12)
    number_fou = (13..16)
    number_fiv = (17..20)
    @number = [number_one, number_two, number_thr, number_fou, number_fiv]
    number_one_dif = (1..2)
    number_two_dif = (3..4)
    number_thr_dif = (5..6)
    number_fou_dif = (7..8)
    number_fiv_dif = (9..10)
    @number_dif = [number_one_dif, number_two_dif, number_thr_dif, number_fou_dif, number_fiv_dif]

  end

  def create
    if  User.find_by(seatNumber:params[:seatNumber])
      redirect_to box_index_path, method:"get"
      flash[:alert] = "이미 신청완료 된 사물함입니다."
    else
      Cabinet.create(cabins:params[:seatNumber])
      current_user.seatNumber = params[:seatNumber]
      current_user.save
      redirect_to '/'
      flash[:success] = "#{current_user.seatNumber} 사물함이 신청되었습니다."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.seatNumber = nil
    cabinet = Cabinet.find_by(user.seatNumber)
    cabinet.destroy
    user.save

    redirect_to new_post_path

    flash[:warning] = "사물함이 취소되었습니다."
  end
end
