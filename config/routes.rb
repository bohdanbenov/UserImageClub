Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  get 'images/index'
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :images, only: [:index, :destroy, :update]
    resources :favs, only: [:index]
  end
  root 'users#index'
end
