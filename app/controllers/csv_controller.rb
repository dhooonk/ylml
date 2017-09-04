class CsvController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?
  def index
    @users = User.all

  end

  def create
    user = User.new(name: params[:name], stuN: params[:stuN], email: params[:email], feeOfSch: params[:feeOfSch], major: params[:major], password: params[:password], identity: params[:identity])


    if User.find_by(stuN: params[:stuN]).present?
      redirect_to csv_index_path, method: "get"
      flash[:warning] = "이미 등록된 학번입니다."
    elsif User.find_by(stuN: params[:stuN]).nil?
      if user_major?.include? params[:major]
        user.save
        redirect_to csv_index_path, method: "get"
        flash[:warning] = "회원정보가 등록되었습니다."
      else
        redirect_to csv_index_path, method: "get"
        flash[:warning] = "권한 내의 학과만 등록이 가능합니다."
      end
    else
      redirect_to csv_index_path, method: "get"
      flash[:warning] = "회원정보 등록이 실패 했습니다. 양식이 올바른지 확인해주세요."
    end
  end

  def import
    User.import(params[:file])
    redirect_to admin_index_path
    flash[:warning] = "회원정보가 등록되었습니다."
  end
end
