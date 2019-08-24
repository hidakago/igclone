Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:create, :destroy, :index]
  resources :pictures do
    collection do
      post :newconfirm
    end
    member do
      put :editconfirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
