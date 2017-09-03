class TempusersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    before_action :admin_not?, except: [:new, :create]
    before_action :reject_access!, only: [:new]

    def new
      @tempuser=Tempuser.new
    end

    def create
      # @tempuser = Tempuser.new
      # @tempuser.name = params[:name]
      # @tempuser.major = params[:major]
      # @tempuser.identity = params[:identity]
      # @tempuser.stuN = params[:stuN]
      # @tempuser.save

      @user=User.find_by(stuN: params[:tempuser][:stuN])
      if @user.nil? && (params[:tempuser][:stuN].length == 10)
        Tempuser.create(name: params[:tempuser][:name],
                      major: params[:tempuser][:major],
                      identity: params[:tempuser][:identity],
                      stuN: params[:tempuser][:stuN],
                      feeOfSch: params[:tempuser][:feeOfSch])
        redirect_to '/'
        flash[:success] = "가입요청이 처리되었습니다."
      elsif @user.present?
        flash[:alert] = "이미 존재하는 회원정보입니다."
        render :template => "/tempusers/new", :locals => {:@tempuser => Tempuser.new}
      else
        flash[:alert] = "학번을 다시 입력해주세요."
        render :template => "/tempusers/new", :locals => {:@tempuser => Tempuser.new}
      end
    end

    def index
      if user_major?.include?  "응용물리학과"
        @tempusers = Tempuser.where(major: user_major?)
      else
        @tmp1 = Tempuser.where(major: user_major?, feeOfSch: true, identity: "1")
        @tmp2 = Tempuser.where(major: user_major?, identity: "2")
        @tmp3 = Tempuser.where(major: user_major?, identity: "3")
      end
    end

    def indexE
      if user_major?.include?  "응용물리학과"
        @tempusers = Tempuser.where(major: user_major?)
      else
        @tmp1 = Tempuser.where(major: user_major?, feeOfSch: true, identity: "1")
        @tmp2 = Tempuser.where(major: user_major?, identity: "2")
        @tmp3 = Tempuser.where(major: user_major?, identity: "3")
      end
    end

end
