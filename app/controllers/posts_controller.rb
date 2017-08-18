class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @limit = Limit.find(1)
    @limit_ = Limit.find(2)
  end

  def new
  end
end
