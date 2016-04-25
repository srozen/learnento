Rails.application.routes.draw do

  api vendor_string: "learnento", default_version: 1 do
    version 1 do
        resources :sessions, only: [:create]
        resources :users, only: [:create, :show, :index, :update]
        resources :friend_requests, only: [:index, :create, :update, :destroy, :show]
        resources :requested_friends, only: [:show]
        resources :pending_friends, only: [:show]
        resources :friends, only: [:index, :update, :destroy]
    end
  end

  root 'angular#app'

end
