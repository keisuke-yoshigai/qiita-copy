class PostsController < ApplicationController
skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html
        @posts = Post.order("created_at DESC").page(params[:page]).per(10)
      format.json
    end
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @user_ids = @post.likes.map{ |like| like.user_id }
    @like = Like.find_by(user_id: current_user.id)
  end

  def new
    @html = view_context.markdown(params[:input]).html_safe if params[:input]
    respond_to do |format|
      format.html
        @post = Post.new
      format.json
    end
  end

  def create
    @post = Post.new(post_strong_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to action: :index
    else
      flash[:alert] = "投稿できませんでした"
      redirect_to action: :new
    end
  end

  def show_matching_keyword
    keywords_ary = current_user.keywords.map{ |keyword| keyword.word }
    titles = Post.arel_table[:title]
    title_sel = titles.matches("\%#{keywords_ary[0]}\%")
    title_sel = titles.matches("%#{keywords_ary[0]}%")
    for i in 1...keywords_ary.length
      title_sel = title_sel.or(titles.matches("\%#{keywords_ary[i]}\%"))
    end
    # logger.debug("SQL: #{Post.where(title_sel).to_sql}")
    @posts = Post.order("created_at DESC").where(title_sel).page(params[:page]).per(10)
    render 'show_matching_keyword'
  end

  def search_post
    @posts = Post.matching_keyword(params[:keyword]).order("created_at DESC").page(params[:page]).per(10)
    render 'show_matching_keyword'
  end

  private

  def post_strong_params
    params.require(:post).permit(:title, :body, :image).merge(user_id: current_user.id)
  end

end
