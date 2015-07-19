Rails.application.routes.draw do

<<<<<<< HEAD
  resources :questions do
    resources :answers, only: [:index, :new, :create, :destroy]
=======
  devise_for :users
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

    resources :answers, concerns: :votable, shallow: true do
      patch :best, on: :member 
    end
  
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd
  end
end

  