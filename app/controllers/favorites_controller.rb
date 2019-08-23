class FavoritesController < ApplicationController
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
