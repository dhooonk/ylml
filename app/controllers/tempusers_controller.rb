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
      @userTemp=Tempuser.find_by(stuN: params[:tempuser][:stuN])
      @user=User.find_by(stuN: params[:tempuser][:stuN])
      if @user.nil? && @userTemp.nil? && (params[:tempuser][:stuN].length == 10)
        Tempuser.create(name: params[:tempuser][:name],
                      major: params[:tempuser][:major],
                      identity: params[:tempuser][:identity],
                      stuN: params[:tempuser][:stuN],
                      feeOfSch: params[:tempuser][:feeOfSch])
        redirect_to '/'
        flash[:success] = "#{params[:tempuser][:name]}님의 가입요청이 완료 됐습니다."
        flash[:alert]   = "#{params[:tempuser][:major]}의 신청기간은 '#{apply_range(params[:tempuser][:major])}'입니다."
      elsif @user.present?
        flash[:alert] = "이미 존재하는 회원정보입니다."
        render :template => "/tempusers/new", :locals => {:@tempuser => Tempuser.new}
      elsif @userTemp.present?
        flash[:alert] = "이미 가입신청을 하셨습니다."
        render :template => "/tempusers/new", :locals => {:@tempuser => Tempuser.new}
      else
        flash[:alert] = "학번을 다시 입력해주세요."
        render :template => "/tempusers/new", :locals => {:@tempuser => Tempuser.new}
      end
    end

    def index
      @tempusers = Tempuser.where(major: user_major?)
      @tempusers.each do |i|
        while Tempuser.where(stuN: i.stuN, name: i.name).count > 1
          Tempuser.find_by(stuN: i.stuN, name: i.name).destroy
        end
      end
    end

    def indexE
      @tempusers = Tempuser.where(major: user_major?)
      @tempusers.each do |i|
        while Tempuser.where(stuN: i.stuN, name: i.name).count > 1
          Tempuser.find_by(stuN: i.stuN, name: i.name).destroy
        end
      end
    end

end
