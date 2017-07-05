class LikesController < ApplicationController

  def create
    create_like
    find_post
    if @post.likes_count
      @likes_count = @post.likes_count
    else
      @likes_count = 0
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def destroy
    find_like
    @like.destroy
    find_post
    if @post.likes_count
      @likes_count = @post.likes_count
    else
      @likes_count = 0
    end
  end

  private

  def create_like
    @like = Like.create(post_id: params[:post_id], user_id: current_user.id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = Like.find(params[:id])
  end
end
