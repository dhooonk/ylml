class ChooseController < ApplicationController
  before_action :authenticate_user!
  before_action :ordinary_user_not?, except: [:destroy]

  def index
    @time_1 = Limit.find(1)#응용화학과
    @time_2 = Limit.find(2)#응용과학대학
    @time_3 = Limit.find(3)#산업경영공학과
    @time_4 = Limit.find(4)#전자정보대학
    if current_user.identity == "1"
      @start_time1 = @time_1.student_time
      @finish_time1 = @time_1.student_time_
      @start_time2 = @time_2.student_time
      @finish_time2 = @time_2.student_time_
      @start_time3 = @time_3.student_time
      @finish_time3 = @time_3.student_time_
      @start_time4 = @time_4.student_time
      @finish_time4 = @time_4.student_time_
    elsif current_user.identity == "2"
      @start_time1 = @time_1.gda_time
      @finish_time1 = @time_1.gda_time_
      @start_time2 = @time_2.gda_time
      @finish_time2 = @time_2.gda_time_
      @start_time4 = @time_4.gda_time
      @finish_time4 = @time_4.gda_time_
    end
  end
end
