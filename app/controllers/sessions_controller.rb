class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to pictures_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to pictures_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash.now[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
