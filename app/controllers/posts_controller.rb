class PostsController < ApplicationController
skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html {
        @posts = Post.includes(:user).order("created_at DESC")
      }
      format.json
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments if @comments
    @post = Post.find(params[:id])
    @user_ids = @post.likes.map{ |like| like.user_id }
    @like = Like.find_by(user_id: current_user.id)
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

  def show_matching_keyword
    @posts = []
    keywords = current_user.keywords
    words = keywords.map{ |keyword| "#{ keyword.word }" }
    words.each do |word|
      @posts.concat(Post.matching_keyword(word)).uniq!
    end
    @posts = @posts.sort{ |a, b| b.created_at <=> a.created_at }
    render 'show_matching_keyword'
  end

  private

  def post_strong_params
    params.require(:post).permit(:title, :body, :image).merge(user_id: current_user.id)
  end

end
