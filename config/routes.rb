Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'questions#index'

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

  