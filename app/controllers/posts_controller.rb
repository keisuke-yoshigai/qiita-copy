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
    @post = Post.new
  end

  def create
    @post = Post.new(post_strong_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to action: :index
    else
      flash.now[:alert] = "投稿できませんでした"
      render "posts/new"
    end
  end

  private

  def post_strong_params
    params.require(:post).permit(:title, :body)
  end

end
