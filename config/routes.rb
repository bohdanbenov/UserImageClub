Rails.application.routes.draw do
  get 'images/index'
  resources :users, only: [:index, :new, :create] do
    resources :images, only: [:index, :destroy, :update]
    resources :favs, only: [:index]
  end
  root 'users#index'
end
