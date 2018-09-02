Rails.application.routes.draw do
  get 'images/index'
  resources :users, only: [:index, :new, :create] do
    resources :images, only: [:index]
  end
  root 'users#index'
end
