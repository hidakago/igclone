class PicturesController < ApplicationController
  def index
    if logged_in?
      @pictures = Picture.all
    else
      redirect_to new_session_path
    end
  end
end
