Rails.application.routes.draw do

  devise_for :users
  resources :questions do
    resources :answers, only: [:index, :new, :create]
  end
  
  resources :answers, only: [:destroy]

  root to: 'questions#index'
end
