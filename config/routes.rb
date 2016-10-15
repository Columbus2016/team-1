Rails.application.routes.draw do
  devise_for :users

  resources :users, except: [:create, :new]

  resources :cancers

  resources :shouts

end
