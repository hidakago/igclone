class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'アカウントを作成しました'
      redirect_to new_session_path
    else
      render 'new'
    end
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
      @pictures = @user.pictures.all.order(:updated_at).reverse_order
    else
      redirect_to new_session_path
    end
  end

  def edit
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params2)
      redirect_to user_path(current_user.id), notice: "プロフィール情報の編集が完了しました！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def user_params2
    params.require(:user).permit(:name,  :email, :comment, :image, :image_cache)
  end
end
