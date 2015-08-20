#require 'sidekiq/web'


Rails.application.routes.draw do

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  resources :questions do
    resources :answers, only: [:index, :new, :create, :destroy]
=======
  devise_for :users
=======
=======
  use_doorkeeper
>>>>>>> lesson-14
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
>>>>>>> lesson-12
  root to: 'questions#index'
  devise_scope :user do
    post 'input_email', to: 'omniauth_callbacks#input_email'
  end

  namespace :api do
    namespace :v1 do 
      resources :profiles do 
        get :me, on: :collection
      end
      resources :questions, shallow: true do 
        resources :answers
      end  
    end
  end


  resources :attachments, only: :destroy

  concern :votable do 
    resources :votes, only: [:up, :down, :cancel] do
      post :up, on: :collection
      post :down, on: :collection
      post :cancel, on: :collection
    end
  end

    
  resources :questions, concerns: :votable do
    resources :comments, only: :create 

    resources :subscriptions, only: :create

    resources :answers, concerns: :votable, shallow: true do
      resources :comments, only: :create 
      patch :best, on: :member 
    end
<<<<<<< HEAD
  
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd
=======
>>>>>>> lesson-10
  end
end

  