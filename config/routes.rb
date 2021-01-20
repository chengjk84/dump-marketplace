Rails.application.routes.draw do

  namespace :admin do
    root 'base#index'
    resources :people

    namespace :businesses do
      resources :verifications
    end
  end

  get '/login', to: 'auth/sessions#new'
  get '/logout', to: 'auth/sessions#destroy'
  get '/register', to: 'auth/registrations#new'

  namespace :auth do
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
  end

  get 'open-a-business', to: 'public/businesses#new', as: 'open_a_business'

  scope module: "public" do

    resources :products, only: [:index, :show]

    resources :businesses do
      resources :products, only: [ :index, :show, :edit]

      namespace :merchant do
        root 'orders#index'

        resources :products
        resources :orders
        resources :reports

        resources :banks
        resources :withdrawals

        resources :conversations
      end
    end

    resources :people do

      resources :favorites
      resources :collections
      resources :networks
      resources :friendships

      resources :carts
      resources :orders
      resources :subscriptions

      resources :wallets
      resources :rewards

      resources :deposits
      resources :withdraws

      resources :conversations
    end

    resources :favorites

  end

  namespace :search do
    resources :people
  end

  post '/billplz/callback', to: 'public/deposits#create'
  get '/join/:sponsor_token', to: 'public/welcome#index'
  root 'public/welcome#index'
end
