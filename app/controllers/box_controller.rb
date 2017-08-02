class BoxController < ApplicationController
  before_action :user_apply?, only: [:index, :create]
  before_action :user_signed?
  def index
    # 행           열 #
    number_one = (1..4)
    number_two = (5..8)
    number_thr = (9..12)
    number_fou = (13..16)
    number_fiv = (17..20)
    number_six = (21..24)
    number_sev = (25..28)
    number_eig = (29..32)
    number_nin = (33..36)
    number_ten = (37..40)
    @number = [number_one, number_two, number_thr, number_fou, number_fiv,
              number_six, number_sev, number_eig, number_nin, number_ten]
    number_one_dif = (1..2)
    number_two_dif = (3..4)
    number_thr_dif = (5..6)
    number_fou_dif = (7..8)
    number_fiv_dif = (9..10)
    number_six_dif = (11..12)
    number_sev_dif = (13..14)
    number_eig_dif = (15..16)
    number_nin_dif = (17..18)
    number_ten_dif = (19..20)
    @number_dif = [number_one_dif, number_two_dif, number_thr_dif, number_fou_dif,
                  number_fiv_dif, number_six_dif, number_sev_dif, number_eig_dif,
                   number_nin_dif, number_ten_dif]

  end

  def create
    if  User.find_by(seatNumber:params[:seatNumber])
      redirect_to box_index_path, method:"get"
      flash[:alert] = "이미 신청완료 된 사물함입니다."
    else
      current_user.seatNumber = params[:seatNumber]
      current_user.save
      redirect_to '/'
      flash[:success] = "사물함이 신청되었습니다."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.seatNumber = nil
    user.save

    redirect_to new_post_path

    flash[:warning] = "사물함이 취소되었습니다."
  end
end
