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
        @user = current_user
        UserMailer.post_notification_mail(@user).deliver
        redirect_to user_path(current_user.id), notice: "投稿を作成しました！"
      else
        render :new
      end
    end
  end

  def show
    if logged_in?
      # 該当の投稿が、既にユーザーがお気に入り済みなのかどうか判断
      @favorite = current_user.favorites.find_by(picture_id: params[:id])
      @picture = Picture.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  def edit
    if logged_in?
      @picture = Picture.find(params[:id])
      if current_user.id != @picture.user.id
        redirect_to picture_path(@picture.id)
      end
    else
      redirect_to new_session_path
    end
  end

  def editconfirm
    if logged_in?
      @picture = Picture.find(params[:id])
      if current_user.id != @picture.user.id
        redirect_to picture_path(@picture.id)
      else
        @picture.comment = params[:picture][:comment]
        render :edit if @picture.invalid?
      end
    else
      redirect_to new_session_path
    end
  end

  def update
    @picture = Picture.find(params[:id])
    if params[:back]
      render :edit
    else
      if @picture.update(picture_params)
        redirect_to user_path(current_user.id), notice: "投稿の編集が完了しました！"
      else
        render :edit
      end
    end
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
