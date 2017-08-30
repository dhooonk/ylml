class CsvController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?
  def index
    @users = User.all

  end

  def create
    user = User.new(name: params[:name], stuN: params[:stuN], email: params[:email], major: params[:major], password: params[:password], identity: params[:identity])

    if user.save
      redirect_to csv_index_path, method: "get"
      flash[:warning] = "회원정보가 등록되었습니다."
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
