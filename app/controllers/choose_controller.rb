class ChooseController < ApplicationController
  before_action :authenticate_user!
  before_action :ordinary_user_not?, except: [:destroy]

  def index
    @time_1 = Limit.find(1)
    @time_2 = Limit.find(2)
    @time_3 = Limit.find(3)
    if current_user.identity == "1"
      @start_time1 = @time_1.student_time
      @finish_time1 = @time_1.student_time_
      @start_time2 = @time_2.student_time
      @finish_time2 = @time_2.student_time_
      @start_time3 = @time_3.student_time
      @finish_time3 = @time_3.student_time_
    elsif current_user.identity == "2"
      @start_time1 = @time_1.gda_time
      @finish_time1 = @time_1.gda_time_
      @start_time2 = @time_2.gda_time
      @finish_time2 = @time_2.gda_time_
      @start_time3 = @time_3.gda_time
      @finish_time3 = @time_3.gda_time_
    end
  end
end
