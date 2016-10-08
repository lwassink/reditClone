Rails.application.routes.draw do
  resources :users, only: [:create, :show, :new]

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy] do
    resources :posts, only: [:new]
  end

  resources :posts, except: [:index, :new] do
    resources :comments, only: [:new]
  end

  root to: "subs#index"

  resources :comments, except: [:index, :new]
end
