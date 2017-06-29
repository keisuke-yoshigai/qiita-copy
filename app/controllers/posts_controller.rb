class PostsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
  end

  def new
  end

end
