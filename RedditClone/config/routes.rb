Rails.application.routes.draw do
  resources :users, only: [:create, :show, :new]

  resource :session, only: [:new, :create, :destroy]

end
