Rails.application.routes.draw do

  root to: "shouts#index"

  devise_for :users

  resources :users, except: [:create, :new] do
    post 'friend', on: :member # NO TIME TO REST THIS IS A HACKATHON
  end

  resources :cancers

  resources :shouts

  resources :comments, only: [:create, :edit, :update]

  get "chat_mockup", to: "static_stuff#chat_mockup"
  get "resources", to: "static_stuff#resources"

  resources :dashboard, only: :index
end
