class KeywordsController < ApplicationController

  def index
    @keyword = Keyword.new
  end

  def create
    @keyword = Keyword.new(keyword_params)
    if @keyword.save
      redirect_to keywords_path, notice: 'キーワードを追加しました'
    else
      flash[:alert] = 'キーワードを追加できませんでした'
      render :index
    end
  end

  def edit
    @keyword = Keyword.find(keyword_params)
    if @keyword.save
      redirect_to :new, notice: 'キーワードを編集しました'
    else
      flash[:alert] = 'キーワードを編集できませんでした'
      render :new
    end
  end

  def destroy
    keyword = Keyword.find(params[:id])
    keyword.destroy
    redirect_to keywords_path, alert: 'キーワードを削除しました'
  end

  private

  def keyword_params
    params.require(:keyword).permit(:word).merge(user_id: current_user.id)
  end
end
