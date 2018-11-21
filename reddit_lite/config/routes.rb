Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:new, :create, :index]
end
