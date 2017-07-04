class LikesController < ApplicationController

  def create
    create_like
    find_likes
    find_post

    if @post.likes_count
      @likes_count = @post.likes_count
    else
      @likes_count = 0
    end
    respond_to do |format|
      format.html
      format.json{
        render 'create', handler: 'jbuilder'
      }
    end
  end

  def destroy
    find_like
    @like.destroy
    find_post
    find_likes

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

  def find_likes
    @likes = Like.where(post_id: params[:post_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = Like.find(params[:id])
  end
end
