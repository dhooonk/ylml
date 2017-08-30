class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    if Limit.find_by(id: current_major?).present?
      @limit = Limit.find_by(id: current_major?.to_i)
    end
  end

  def new
  end
end
