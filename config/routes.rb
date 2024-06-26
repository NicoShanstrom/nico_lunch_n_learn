Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index]
      resources :learning_resources, only: [:index]
      resources :favorites, only: [:create, :index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :tourist_sites, only: [:index]
    end
  end
end
# Defines the root path route ("/")
# root "posts#index"
