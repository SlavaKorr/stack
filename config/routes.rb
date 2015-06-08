Rails.application.routes.draw do

  resources :questions do
    resources :answers, only: [:index, :new, :create, :destroy]
  end
end
