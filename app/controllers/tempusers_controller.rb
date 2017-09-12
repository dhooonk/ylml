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
        flash[:info]   = "#{params[:tempuser][:major]}의 사물함 신청기간은 '#{apply_range(params[:tempuser][:major])}'입니다."
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

    def select
      @tempusers = Tempuser.where(major: user_major?)
      @tempusers.each do |i|
        while Tempuser.where(stuN: i.stuN, name: i.name).count > 1
          Tempuser.find_by(stuN: i.stuN, name: i.name).destroy
        end
      end
    end

    def accept
      user = User.new(name: params[:name],
                      stuN: params[:stuN],
                      feeOfSch: params[:feeOfSch],
                      major: params[:major],
                      password: params[:stuN],
                      identity: params[:identity])
      if User.find_by(stuN: params[:stuN]).present?
        redirect_to tempusers_select_path, method: "get"
        flash[:warning] = "이미 등록된 학번입니다."
      elsif User.find_by(stuN: params[:stuN]).nil?
        if user_major?.include? params[:major]
          user.save
          redirect_to tempusers_select_path, method: "get"
          flash[:success] = "회원정보가 등록되었습니다."
        else
          redirect_to tempusers_select_path, method: "get"
          flash[:warning] = "권한 내의 학과만 등록이 가능합니다."
        end
      else
        redirect_to tempusers_select_path, method: "get"
        flash[:warning] = "회원정보 등록이 실패 했습니다."
      end
    end
    def destroy
      tempuser = Tempuser.find(params[:id])
      if user_major?.include? tempuser.major
        tempuser.destroy
        flash[:warning] = "가입신청 정보가 삭제 되었습니다."
        redirect_to tempusers_select_path, method: "get"
      else
        flash[:warning] = "해당 권한이 없습니다."
        redirect_to tempusers_select_path, method: "get"
      end
    end
end
