class TempusersController < ApplicationController
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
      @user=User.find(params[:stuN])
      Tempuser.create(name: params[:tempuser][:name],
                      major: params[:tempuser][:major],
                      identity: params[:tempuser][:identity],
                      stuN: params[:tempuser][:stuN])

      redirect_to '/'
    end

    def index
      @tempusers = Tempuser.all
    end

    def indexE
      @tempusers = Tempuser.all
    end

end
