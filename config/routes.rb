Rails.application.routes.draw do
  
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "works#index"

  # this sets up a controller method for pages#index, but we don't need this
  # resources :pages, only: [:index]

  # resources :applications
  resources :works

end

