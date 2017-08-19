class CsvController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_not?
  def index
    @users = User.all

  end

  def create
    User.create(name:params[:name], stuN:params[:stuN], email:params[:email],
                password:params[:password], identity: params[:identity])
    redirect_to admin_index_path
    flash[:warning] = "회원정보가 등록되었습니다."
  end

  def import
    User.import(params[:file])
    redirect_to admin_index_path
    flash[:warning] = "회원정보가 등록되었습니다."
  end
end
