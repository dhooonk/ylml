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
      @user=User.find_by(stuN: params[:stuN])
      if @user.nil?
        Tempuser.create(name: params[:tempuser][:name],
                      major: params[:tempuser][:major],
                      identity: params[:tempuser][:identity],
                      stuN: params[:tempuser][:stuN])
      end

      redirect_to '/'
    end

    def index
      @tempusers = Tempuser.where(major: user_major?)
    end

    def indexE
      @tempusers = Tempuser.where(major: user_major?)
    end

end
