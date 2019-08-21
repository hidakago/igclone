class PicturesController < ApplicationController
  def index
    if logged_in?
      @pictures = Picture.all.order(:updated_at).reverse_order
    else
      redirect_to new_session_path
    end
  end

  def new
    if logged_in?
      @picture = Picture.new
    else
      redirect_to new_session_path
    end
  end

  def newconfirm
    if logged_in?
      @picture = Picture.new(picture_params)
      @picture.user_id = current_user.id
      render :new if @picture.invalid?
    else
      redirect_to new_session_path
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to user_path(current_user.id), notice: "投稿を作成しました！"
      else
        render :new
      end
    end
  end

  def show
    if logged_in?
      @picture = Picture.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to user_path(current_user.id), notice:"投稿を削除しました！"
  end

  private

  def picture_params
    params.require(:picture).permit(:comment, :image, :user_id, :image_cache)
  end
end
