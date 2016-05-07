Rails.application.routes.draw do

  api vendor_string: "learnento", default_version: 1 do
    version 1 do
        resources :sessions, only: [:create]
        resources :users, only: [:create, :show, :index, :update]
        resources :friend_requests, only: [:index, :create, :update, :destroy, :show]
        resources :requested_friends, only: [:show]
        resources :pending_friends, only: [:show]
        resources :friends, only: [:index, :update, :destroy, :show]
        resources :active_friend_notifications, only: [:index, :destroy]
        resources :active_messaging_notifications, only: [:index, :destroy]
        resources :messages, only: [:create]
        resources :conversations, only: [:show, :index]
    end
  end

  root 'angular#app'

end
