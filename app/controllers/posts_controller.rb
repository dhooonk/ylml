class PostsController < ApplicationController
  before_action :user_signed?, only: [:new]
  def index

  end

  def new
  end
end
