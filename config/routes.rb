Rails.application.routes.draw do
  
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "works#home"

  # this sets up a controller method for pages#index, but we don't need this
  # resources :pages, only: [:index]

  # resources :applications
  resources :works do
    resources :votes
  end
  resources :users do
    resources :votes
  end
  resources :votes

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

end

