class LimitsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?
  def edit
    @limit = Limit.find(1)
    @limit_ = Limit.find(2)
  end

  def update
    @limit = Limit.find(1)
    @limit_ = Limit.find(2)

    if params[:student_time].nil?
      @limit.student_time = (Time.now + 000101010110)
    else
      if params[:student_time].length != 16
        @limit.student_time = (Time.now + 000101010110)
      else
        limit = params[:student_time]
        @limit.student_time = "#{limit} +0900"
      end
    end

    if params[:student_time_].nil?
      @limit_.student_time = (Time.now + 000101010110)
    else
      if params[:student_time_].length != 16
        @limit_.student_time = (Time.now + 000101010110)
      else
        limit = params[:student_time_]
        @limit_.student_time = "#{limit} +0900"
      end
    end

    if params[:gda_time].nil?
      @limit.gda_time = (Time.now + 000101010110)
    else
      if params[:gda_time].length != 16
        @limit.gda_time = (Time.now + 000101010110)
      else
        limit = params[:gda_time]
        @limit.gda_time = "#{limit} +0900"
      end
    end

    if params[:gda_time_].nil?
      @limit_.gda_time = (Time.now + 000101010110)
    else
      if params[:gda_time_].length != 16
        @limit_.gda_time = (Time.now + 000101010110)
      else
        limit = params[:gda_time_]
        @limit_.gda_time = "#{limit} +0900"
      end
    end

    @limit.save
    @limit_.save
    redirect_to edit_limit_path(1), method: "get"
  end
end
