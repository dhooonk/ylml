class BoxController < ApplicationController
  before_action :authenticate_user!
  before_action :ordinary_user_not?, except: [:destroy]
  before_action :access_okay?
  before_action :applchem_not?, only: [:index]
  before_action :applsci_not?, only: [:applsci]
  before_action :ime_not?, only: [:ime]
  before_action :authenticate_admin!, except: [:destroy]
  before_action :authenticate_admin_ver_destroy!, only: [:destroy]
  before_action :user_apply?, except: [:destroy_apli_chem, :destroy_apli_sci, :destroy_ime]
  before_action :user_apply_chem?, only: [:index]
  before_action :user_apply_chem_aplisci?, only: [:applsci]


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

  def applsci
    @cabinets = CabinetApliSci.all
    # 행           열 #
    number_1 = ["01", "02", "03", "04", "05", "06"]
    number_2 = (13..18)
    number_3 = (25..30)
    number_4 = (37..42)
    number_5 = (49..54)
    @number_01tohalf = [number_1, number_2, number_3, number_4, number_5]
    number_6 = ["07", "08", "09", "10", "11", "12"]
    number_7 = (19..24)
    number_8 = (31..36)
    number_9 = (43..48)
    number_10 = (55..60)
    @number_halfto60 = [number_6, number_7, number_8, number_9, number_10]

  end

  def ime
    @cabinets = CabinetApliSci.all
    # 행           열 #
    number_1 = ["01", "02", "03"]
    number_2 = ["04", "05", "06"]
    number_3 = ["07", "08", "09"]
    number_4 = (10..12)
    number_5 = (13..15)
    @number_01to15 = [number_1, number_2, number_3, number_4, number_5]
    number_6 = (16..18)
    number_7 = (19..21)
    number_8 = (22..24)
    number_9 = (25..27)
    number_10 = (28..30)
    @number_16to30 = [number_6, number_7, number_8, number_9, number_10]
    number_11 = (31..33)
    number_12 = (34..36)
    number_13 = (37..39)
    number_14 = (40..42)
    number_15 = (43..45)
    @number_31to45 = [number_11, number_12, number_13, number_14, number_15]
    number_16 = (46..48)
    number_17 = (49..51)
    number_18 = (52..54)
    number_19 = (55..57)
    number_20 = (58..60)
    @number_46to60 = [number_16, number_17, number_18, number_19, number_20]
    number_21 = (61..63)
    number_22 = (64..66)
    number_23 = (67..69)
    number_24 = (70..72)
    number_25 = (73..75)
    @number_61to75 = [number_21, number_22, number_23, number_24, number_25]
    number_26 = (76..78)
    number_27 = (79..81)
    number_28 = (82..84)
    number_29 = (85..87)
    number_30 = (88..90)
    @number_76to90 = [number_26, number_27, number_28, number_29, number_30]
    number_31 = (91..93)
    number_32 = (94..96)
    number_33 = (97..99)
    number_34 = (100..102)
    number_35 = (103..105)
    @number_91to105 = [number_31, number_32, number_33, number_34, number_35]
    number_36 = (106..108)
    number_37 = (109..111)
    number_38 = (112..114)
    number_39 = (115..117)
    number_40 = (118..120)
    @number_106to120 = [number_36, number_37, number_38, number_39, number_40]
    number_41 = (121..123)
    number_42 = (124..126)
    number_43 = (127..129)
    number_44 = (130..132)
    number_45 = (133..135)
    @number_121to135 = [number_41, number_42, number_43, number_44, number_45]

  end

  def create
    if current_user.major == "응용화학과"
      if params[:major] == "응용화학과"
        if Cabinet.find_by(cabins:params[:seatNumber])
          redirect_to box_index_path, method:"get"
          flash[:alert] = "이미 신청완료 된 사물함입니다."
        else
          Cabinet.create(cabins: params[:seatNumber], major: current_user.major, user_id: current_user.id)
          redirect_to new_post_path, method: "get"
          flash[:success] = "#{params[:seatNumber]}번 사물함이 신청되었습니다."
        end
      elsif params[:major] == "응용과학대학"
        if CabinetApliSci.find_by(cabins_aplsci: params[:seatNumber])
          redirect_to box_applsci_path, method:"get"
          flash[:alert] = "이미 신청완료 된 사물함입니다."
        else
          CabinetApliSci.create(cabins_aplsci: params[:seatNumber], user_id: current_user.id)
          redirect_to new_post_path, method: "get"
          flash[:success] = "#{params[:seatNumber]}번 사물함이 신청되었습니다."
        end
      end
    elsif (current_user.major == "응용물리학과") || (current_user.major == "우주과학과") || (current_user.major == "응용수학과")
      if CabinetApliSci.find_by(cabins_aplsci: params[:seatNumber])
        redirect_to box_applsci_path, method:"get"
        flash[:alert] = "이미 신청완료 된 사물함입니다."
      else
        CabinetApliSci.create(cabins_aplsci: params[:seatNumber], user_id: current_user.id)
        redirect_to new_post_path, method: "get"
        flash[:success] = "#{params[:seatNumber]}번 사물함이 신청되었습니다."
      end
    else
      if CabinetIme.find_by(cabins_ime: params[:seatNumber])
        redirect_to box_ime_path, method:"get"
        flash[:alert] = "이미 신청완료 된 사물함입니다."
      else
        CabinetIme.create(cabins_ime: params[:seatNumber], user_id: current_user.id)
        redirect_to new_post_path, method: "get"
        flash[:success] = "#{params[:seatNumber]}번 사물함이 신청되었습니다."
      end
    end
  end

  def destroy_apli_chem

    cabinet = Cabinet.find_by(user_id: params[:id])
    cabinet.destroy
    redirect_to new_post_path

    flash[:warning] = "사물함이 취소되었습니다."
  end

  def destroy_apli_sci
    cabinet = CabinetApliSci.find_by(user_id: params[:id])
    cabinet.destroy
    redirect_to new_post_path

    flash[:warning] = "사물함이 취소되었습니다."
  end

  def destroy_ime
    cabinet = CabinetIme.find_by(user_id: params[:id])
    cabinet.destroy
    redirect_to new_post_path

    flash[:warning] = "사물함이 취소되었습니다."
  end

  private
  def authenticate_admin!
    if (current_user.identity != "admin") && (current_user.identity != "3")
      if (current_time > Time.now) || (Time.now > final_time)
        redirect_to root_path
        flash[:alert] = "신청기간이 아닙니다."
      end
    end
  end

  def authenticate_admin_ver_destroy!
    if (current_user.identity != "admin") && (current_user.identity != "3")
      if (current_time > Time.now) || (Time.now > final_time)
        redirect_to root_path
        flash[:alert] = "신청기간이 아니므로 사물함 취소가 불가합니다. 학생회에 문의하세요."
      end
    end
  end
  ##
end
