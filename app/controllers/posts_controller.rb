class PostsController < ApplicationController
skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html {
        @posts = Post.includes(:user).order("created_at DESC").limit(10)
      }
      format.json
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @html = view_context.markdown(params[:input]).html_safe if params[:input]
    respond_to do |format|
      format.html {
        @post = Post.new
      }
      format.json {
        render 'new', handler: 'jbuilder'
      }
    end
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

  def preview
    redirect_to action: :new
  end

  private

  def post_strong_params
    params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
  end

end
