class FavoritesController < ApplicationController
  def index
    if logged_in?
      @pictures = current_user.favorite_pictures.all.order(:updated_at).reverse_order
    else
      redirect_to new_session_path
    end
  end

  def create
    favorite = current_user.favorites.create(picture_id: params[:id])
    redirect_to picture_path(params[:id]), notice: "#{favorite.picture.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    back_id = current_user.favorites.find_by(id: params[:id]).picture_id
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to picture_path(back_id), notice: "#{favorite.picture.user.name}さんの投稿をお気に入り解除しました"
  end
end
