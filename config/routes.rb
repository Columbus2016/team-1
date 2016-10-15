Rails.application.routes.draw do
  devise_for :users

  resources :users, except: [:create, :new] do
    post 'friend', on: :member # NO TIME TO REST THIS IS A HACKATHON
  end

  resources :cancers

  resources :shouts

  resources :comments, only: [:create, :edit, :update]
end
