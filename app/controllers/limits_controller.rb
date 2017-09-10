class LimitsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?
  def edit
    if current_user.major == "응용화학과"
      @limit = Limit.find(1)
      @limit_id = 1
    elsif (current_user.major == "응용물리학과") || (current_user.major == "우주과학과") || (current_user.major == "응용수학과")
      @limit = Limit.find(2)
      @limit_id = 2
    elsif current_user.major == "산업경영공학과"
      @limit = Limit.find(3)
      @limit_id = 3
    elsif (current_user.major == "전자공학과") || (current_user.major == "컴퓨터공학과") || (current_user.major == "생체의공학과")|| (current_user.major == "소프트웨어융합학과")
      @limit = Limit.find(4)
      @limit_id = 4
    end
  end

  def update
    @limit = Limit.find(params[:id])

    if params[:student_time].nil?
      @limit.student_time = (Time.now + 100000000)
    else
      if params[:student_time].length != 16
        @limit.student_time = (Time.now + 100000000)
      else
        limit = params[:student_time]
        @limit.student_time = "#{limit} +0900"
      end
    end

    if params[:student_time_].nil?
      @limit.student_time_ = (Time.now + 110000000)
    else
      if params[:student_time_].length != 16
        @limit.student_time_ = (Time.now + 110000000)
      else
        limit = params[:student_time_]
        @limit.student_time_ = "#{limit} +0900"
      end
    end

    if params[:gda_time].nil?
      @limit.gda_time = (Time.now + 100000000)
    else
      if params[:gda_time].length != 16
        @limit.gda_time = (Time.now + 100000000)
      else
        limit = params[:gda_time]
        @limit.gda_time = "#{limit} +0900"
      end
    end

    if params[:gda_time_].nil?
      @limit.gda_time_ = (Time.now + 110000000)
    else
      if params[:gda_time_].length != 16
        @limit.gda_time_ = (Time.now + 110000000)
      else
        limit = params[:gda_time_]
        @limit.gda_time_ = "#{limit} +0900"
      end
    end

    if @limit.save
      redirect_to edit_limit_path(params[:id]), method: "get"
      flash[:success] = "신청기간 설정을 완료하였습니다."
    else
      redirect_to edit_limit_path(params[:id]), method: "get"
      flash[:alert] = "신청기간 설정에 실패했습니다. 양식에 맞춰 작성해주세요."
    end
  end
end
