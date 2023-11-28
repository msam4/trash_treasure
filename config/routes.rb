Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/filter", to: 'places#filter'
  # Defines the root path route ("/")
  # root "posts#index"
  resources :places, only: [:index, :show, :new, :create] do
    member do
      get 'update', to: 'places#update_form', as: 'update_form'
      post 'update', to: 'places#update', as: 'update_place'
    end
    resources :trash_bins, only: [:new, :create, :edit, :update]
  end

  resources :trash_bins, only: [:destroy, :update] do
    resources :tosses, only: [:new, :create]
  end

  #vincci test
  get "/test", to: 'pages#test'

end
