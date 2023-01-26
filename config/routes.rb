Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#new"
  # root to: "users#new"


  get "/profil", to: "users#edit", as: :profil
  patch "/profil", to: "users#update"
  # get "/login", :new
  
  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :destroy_session
  # resources :sessions, only: [:new, :create, :destroy]

  resources :passwords, only: [:new, :create, :edit, :update]
  
  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
    end
  end
  
end
