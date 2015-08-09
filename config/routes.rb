Rails.application.routes.draw do

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
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



  resources :attachments, only: [:destroy]

  concern :votable do 
    resources :votes, only: [:up, :down, :cancel] do
      post :up, on: :collection
      post :down, on: :collection
      post :cancel, on: :collection
    end
  end

    
  resources :questions, concerns: :votable do
    resources :comments, only: [:create] 

    resources :answers, concerns: :votable, shallow: true do
      resources :comments, only: [:create] 
      patch :best, on: :member 
    end
  end
end

  