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
      if @user.nil?
        Tempuser.create(name: params[:tempuser][:name],
                      major: params[:tempuser][:major],
                      identity: params[:tempuser][:identity],
                      stuN: params[:tempuser][:stuN],
                      feeOfSch: params[:tempuser][:feeOfSch])
        redirect_to '/'
        flash[:success] = "가입요청이 처리되었습니다."
      else
        redirect_to '/'
        flash[:alert] = "이미 존재하는 회원정보입니다."
      end
    end

    def index
      if user_major?.include?  "응용물리학과"
        @tempusers = Tempuser.where(major: user_major?)
      else
        @tempusers = []
        tmp1 = Tempuser.where(major: user_major?, feeOfSch: true, identity: "1")
        tmp2 = Tempuser.where(major: user_major?, identity: "2", identity: "3")
        tmp1.each_with_index do |a,i|
          @tempusers << a
          @tempusers << tmp2[i]
        end
      end
    end

    def indexE
      if user_major?.include?  "응용물리학과"
        @tempusers = Tempuser.where(major: user_major?)
      else
        @tempusers = []
        tmp1 = Tempuser.where(major: user_major?, feeOfSch: true, identity: "1")
        tmp2 = Tempuser.where(major: user_major?, identity: "2", identity: "3")
        tmp1.each_with_index do |a,i|
          @tempusers << a
          @tempusers << tmp2[i]
        end
      end
    end

end
